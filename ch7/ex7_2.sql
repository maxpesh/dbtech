SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

COPY bookings.translations (transl_id, translation, language) FROM stdin;
1	Yakutsk	en
1	Якутск	ru
2	Mirnyj	en
2	Мирный	ru
3	Khabarovsk	en
3	Хабаровск	ru
4	Petropavlovsk	en
4	Петропавловск-Камчатский	ru
5	Yuzhno-Sakhalinsk	en
5	Южно-Сахалинск	ru
6	Vladivostok	en
6	Владивосток	ru
7	St. Petersburg	en
7	Санкт-Петербург	ru
8	Kaliningrad	en
8	Калининград	ru
9	Kemorovo	en
9	Кемерово	ru
10	Chelyabinsk	en
10	Челябинск	ru
11	Magnetiogorsk	en
11	Магнитогорск	ru
12	Perm	en
12	Пермь	ru
13	Surgut	en
13	Сургут	ru
14	Bryansk	en
14	Брянск	ru
15	Mineralnye Vody	en
15	Минеральные Воды	ru
16	Stavropol	en
16	Ставрополь	ru
17	Astrakhan	en
17	Астрахань	ru
18	Nizhnevartovsk	en
18	Нижневартовск	ru
19	Yekaterinburg	en
19	Екатеринбург	ru
20	Moscow	en
20	Москва	ru
21	Voronezh	en
21	Воронеж	ru
22	Moscow	en
22	Москва	ru
23	Syktyvkar	en
23	Сыктывкар	ru
24	Samara	en
24	Самара	ru
25	Moscow	en
25	Москва	ru
26	Tyumen	en
26	Тюмень	ru
27	Nizhniy Novgorod	en
27	Нижний Новгород	ru
28	Tomsk	en
28	Томск	ru
29	Ust Ilimsk	en
29	Усть-Илимск	ru
30	Norilsk	en
30	Норильск	ru
31	Arkhangelsk	en
31	Архангельск	ru
32	Saratov	en
32	Саратов	ru
33	Novy Urengoy	en
33	Новый Уренгой	ru
34	Noyabrsk	en
34	Ноябрьск	ru
35	Ukhta	en
35	Ухта	ru
36	Usinsk	en
36	Усинск	ru
37	Naryan-Mar	en
37	Нарьян-Мар	ru
38	Pskov	en
38	Псков	ru
39	Kogalym	en
39	Когалым	ru
40	Krasnoyarsk	en
40	Красноярск	ru
41	Uraj	en
41	Урай	ru
42	Ivanovo	en
42	Иваново	ru
43	Yakutia	en
43	Удачный	ru
44	Komsomolsk-on-Amur	en
44	Комсомольск-на-Амуре	ru
45	Anadyr	en
45	Анадырь	ru
46	Petrozavodsk	en
46	Петрозаводск	ru
47	Kyzyl	en
47	Кызыл	ru
48	Novokuznetsk	en
48	Новокузнецк	ru
49	Grozny	en
49	Грозный	ru
50	Nalchik	en
50	Нальчик	ru
51	Beslan	en
51	Владикавказ	ru
52	Elista	en
52	Элиста	ru
53	Salekhard	en
53	Салехард	ru
54	Khanty-Mansiysk	en
54	Ханты-Мансийск	ru
55	Nyagan	en
55	Нягань	ru
56	Sovetskiy	en
56	Советский	ru
57	Izhevsk	en
57	Ижевск	ru
58	Kirov	en
58	Киров	ru
59	Nadym	en
59	Надым	ru
60	Nefteyugansk	en
60	Нефтеюганск	ru
61	Kurgan	en
61	Курган	ru
62	Belgorod	en
62	Белгород	ru
63	Kursk	en
63	Курск	ru
64	Lipetsk	en
64	Липецк	ru
65	Vorkuta	en
65	Воркута	ru
66	Bugulma	en
66	Бугульма	ru
67	Yoshkar-Ola	en
67	Йошкар-Ола	ru
68	Cheboksary	en
68	Чебоксары	ru
69	Ulyanovsk	en
69	Ульяновск	ru
70	Orsk	en
70	Орск	ru
71	Penza	en
71	Пенза	ru
72	Saransk	en
72	Саранск	ru
73	Tambow	en
73	Тамбов	ru
74	Ust-Kut	en
74	Усть-Кут	ru
75	Gelendzhik	en
75	Геленджик	ru
76	Yaroslavl	en
76	Ярославль	ru
77	Nizhnekamsk	en
77	Нижнекамск	ru
78	Ulyanovsk	en
78	Ульяновск	ru
79	Strezhevoy	en
79	Стрежевой	ru
80	Beloyarsky	en
80	Белоярский	ru
81	Kaluga	en
81	Калуга	ru
82	Gorno-Altaysk	en
82	Горно-Алтайск	ru
83	Krasnodar	en
83	Краснодар	ru
84	Makhachkala	en
84	Махачкала	ru
85	Kazan	en
85	Казань	ru
86	Orenburg	en
86	Оренбург	ru
87	Ufa	en
87	Уфа	ru
88	Novosibirsk	en
88	Новосибирск	ru
89	Cherepovets	en
89	Череповец	ru
90	Omsk	en
90	Омск	ru
91	Rostov	en
91	Ростов-на-Дону	ru
92	Sochi	en
92	Сочи	ru
93	Volgograd	en
93	Волгоград	ru
94	Blagoveschensk	en
94	Благовещенск	ru
95	Magadan	en
95	Магадан	ru
96	Chita	en
96	Чита	ru
97	Bratsk	en
97	Братск	ru
98	Irkutsk	en
98	Иркутск	ru
99	Ulan-ude	en
99	Улан-Удэ	ru
100	Murmansk	en
100	Мурманск	ru
101	Abakan	en
101	Абакан	ru
102	Barnaul	en
102	Барнаул	ru
103	Anapa	en
103	Анапа	ru
104	Neryungri	en
104	Нерюнгри	ru
\.

