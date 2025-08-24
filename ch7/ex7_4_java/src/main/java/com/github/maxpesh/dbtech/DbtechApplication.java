package com.github.maxpesh.dbtech;

import java.sql.*;
import java.util.List;

public class DbtechApplication {
    public static void main(String[] args) {
        var scheduledDeparture = "2017-09-09 16:00:00+00";
        var departureAirport = "LED";
        var bookRef = "_1C91";
        List<Passenger> passengers = List.of(
                new Passenger("4030 855525", "Vasya Pupkin"),
                new Passenger("4030 855525", "Neville Longbottom")
        );
        List<String> ticketNos = List.of("0005435999874", "0005435999875");

        buyTickets(scheduledDeparture, departureAirport, bookRef, passengers, ticketNos);
    }

    private static void buyTickets(String scheduledDeparture, String departureAirport, String bookRef, List<Passenger> passengers, List<String> ticketNos) {
        try (var conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/demo?user=postgres&password=secret")) {
            conn.setAutoCommit(false);
            conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

            if (!conn.getMetaData().supportsResultSetType(ResultSet.TYPE_SCROLL_INSENSITIVE)) {
                throw new SQLFeatureNotSupportedException();
            }
            int retries = 3;
            while (true) {
                try {
                    saveTicketsToDb(scheduledDeparture, departureAirport, bookRef, passengers, ticketNos, conn);
                    break;
                } catch (SQLIntegrityConstraintViolationException exception) {
                    retries--;
                    if (retries == 0)
                        throw new RuntimeException();
                }
            }
        } catch (SQLException ex) {
            do {
                ex.printStackTrace(System.err);
                System.err.println("SQLState: " + ex.getSQLState());
                System.err.println("Error Code: " + ex.getErrorCode());
                System.err.println("Message: " + ex.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            } while ((ex = ex.getNextException()) != null);
        }
    }

    private static void saveTicketsToDb(String scheduledDeparture, String departureAirport, String bookRef, List<Passenger> passengers, List<String> ticketNos, Connection conn) throws SQLException {
        String flightId;
        try (var st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            var rs = st.executeQuery("""
                    select flight_id
                    from flights
                    where scheduled_departure = '%s'
                      and departure_airport = '%s';""".formatted(scheduledDeparture, departureAirport));
            rs.first();
            flightId = rs.getString("flight_id");
        }
        try (var st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            st.addBatch("""
                    insert into bookings(book_ref, book_date, total_amount) values('%s', now(), 0);"""
                    .formatted(bookRef));
            for (int i = 0; i < passengers.size(); i++) {
                Passenger passenger = passengers.get(i);
                var ticketNo = ticketNos.get(i);
                st.addBatch("""
                        insert into tickets(ticket_no, book_ref, passenger_id, passenger_name) \
                        values('%s', '%s', '%s', '%s');"""
                        .formatted(ticketNo, bookRef, passenger.id(), passenger.name()));
                st.addBatch("""
                        insert into ticket_flights(ticket_no, flight_id, fare_conditions, amount) \
                        values('%s', '%s', '%s', '%s');"""
                        .formatted(ticketNo, flightId, "Economy", 35000));
            }
            st.addBatch("""
                    update bookings set total_amount = (
                      select sum(amount)
                      from bookings b
                      inner join tickets t on t.book_ref = b.book_ref
                      inner join ticket_flights tf on tf.ticket_no = t.ticket_no
                      where b.book_ref = '%s'
                    );"""
                    .formatted(bookRef));
            var updateCnts = st.executeBatch();
            for (var updateCnt : updateCnts) {
                assert updateCnt == (2 * passengers.size() + 1);
            }
            conn.rollback();
        }
    }
}

record Passenger(String id, String name) {
}