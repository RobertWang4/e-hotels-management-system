-- ============================================================
-- e-Hotels Sample Data
-- Insert order follows foreign key dependencies
-- ============================================================

-- 1. Hotel Chains (5 chains with real HQ addresses)
INSERT INTO hotel_chain (chain_id, name, central_office_address, contact_email, contact_phone) VALUES
(1, 'Marriott International', '7750 Wisconsin Ave, Bethesda, MD 20814, USA', 'contact@marriott.com', '1-301-380-3000'),
(2, 'Hilton Hotels & Resorts', '7930 Jones Branch Dr, McLean, VA 22102, USA', 'contact@hilton.com', '1-703-883-1000'),
(3, 'Hyatt Hotels Corporation', '150 N Riverside Plaza, Chicago, IL 60606, USA', 'contact@hyatt.com', '1-312-750-1234'),
(4, 'Wyndham Hotels & Resorts', '22 Sylvan Way, Parsippany, NJ 07054, USA', 'contact@wyndham.com', '1-973-753-6000'),
(5, 'IHG Hotels & Resorts', '3 Ravinia Dr, Atlanta, GA 30346, USA', 'contact@ihg.com', '1-770-604-2000');

-- Reset sequences
SELECT setval('hotel_chain_chain_id_seq', 5);

-- 2. Hotels (8 per chain = 40 total, various categories, some sharing areas)
-- Marriott (chain_id=1): categories 3,4,5,3,4,5,2,3
INSERT INTO hotel (hotel_id, chain_id, name, category, address, area, contact_email, contact_phone) VALUES
(1,  1, 'Marriott Downtown Toronto',     5, '100 Front St W, Toronto, ON',       'Toronto',    'toronto.dt@marriott.com',    '416-555-0101'),
(2,  1, 'Marriott Ottawa Rideau',        4, '50 Rideau St, Ottawa, ON',          'Ottawa',     'ottawa@marriott.com',        '613-555-0102'),
(3,  1, 'Marriott Vancouver Waterfront', 5, '1128 W Hastings St, Vancouver, BC', 'Vancouver',  'vancouver@marriott.com',     '604-555-0103'),
(4,  1, 'Marriott Calgary Airport',      3, '2500 Airport Rd NE, Calgary, AB',   'Calgary',    'calgary@marriott.com',       '403-555-0104'),
(5,  1, 'Marriott Montreal Centre',      4, '1000 Rue de la Gauchetiere, Montreal, QC', 'Montreal', 'montreal@marriott.com', '514-555-0105'),
(6,  1, 'Marriott Halifax Harbour',      3, '1919 Upper Water St, Halifax, NS',  'Halifax',    'halifax@marriott.com',       '902-555-0106'),
(7,  1, 'Marriott Winnipeg Downtown',    2, '161 Donald St, Winnipeg, MB',       'Winnipeg',   'winnipeg@marriott.com',      '204-555-0107'),
(8,  1, 'Marriott Toronto Airport',      3, '901 Dixon Rd, Toronto, ON',         'Toronto',    'toronto.air@marriott.com',   '416-555-0108');

-- Hilton (chain_id=2): categories 4,5,3,4,2,3,5,4
INSERT INTO hotel (hotel_id, chain_id, name, category, address, area, contact_email, contact_phone) VALUES
(9,  2, 'Hilton Toronto Downtown',     4, '145 Richmond St W, Toronto, ON',     'Toronto',    'toronto@hilton.com',       '416-555-0201'),
(10, 2, 'Hilton Quebec City',          5, '1100 Rene Levesque Blvd, Quebec, QC','Quebec City','quebec@hilton.com',        '418-555-0202'),
(11, 2, 'Hilton Edmonton',             3, '10235 101 St NW, Edmonton, AB',      'Edmonton',   'edmonton@hilton.com',      '780-555-0203'),
(12, 2, 'Hilton Vancouver Metrotown',  4, '6083 McKay Ave, Burnaby, BC',        'Vancouver',  'burnaby@hilton.com',       '604-555-0204'),
(13, 2, 'Hilton London Ontario',       2, '300 King St, London, ON',            'London',     'london@hilton.com',        '519-555-0205'),
(14, 2, 'Hilton Ottawa Congress',      3, '361 Queen St, Ottawa, ON',           'Ottawa',     'ottawa@hilton.com',        '613-555-0206'),
(15, 2, 'Hilton Montreal Bonaventure', 5, '900 Rue de la Gauchetiere, Montreal, QC', 'Montreal','montreal@hilton.com',   '514-555-0207'),
(16, 2, 'Hilton Niagara Falls',        4, '6361 Fallsview Blvd, Niagara Falls, ON', 'Niagara Falls','niagara@hilton.com','905-555-0208');

-- Hyatt (chain_id=3): categories 5,3,4,2,5,3,4,1
INSERT INTO hotel (hotel_id, chain_id, name, category, address, area, contact_email, contact_phone) VALUES
(17, 3, 'Hyatt Regency Toronto',       5, '370 King St W, Toronto, ON',         'Toronto',    'toronto@hyatt.com',        '416-555-0301'),
(18, 3, 'Hyatt Place Edmonton',        3, '10010 104 St NW, Edmonton, AB',      'Edmonton',   'edmonton@hyatt.com',       '780-555-0302'),
(19, 3, 'Hyatt Regency Calgary',       4, '700 Centre St SE, Calgary, AB',      'Calgary',    'calgary@hyatt.com',        '403-555-0303'),
(20, 3, 'Hyatt Place Mississauga',     2, '5500 Dixie Rd, Mississauga, ON',     'Mississauga','mississauga@hyatt.com',    '905-555-0304'),
(21, 3, 'Hyatt Regency Vancouver',     5, '655 Burrard St, Vancouver, BC',      'Vancouver',  'vancouver@hyatt.com',      '604-555-0305'),
(22, 3, 'Hyatt Place Ottawa',          3, '55 Laurier Ave E, Ottawa, ON',       'Ottawa',     'ottawa@hyatt.com',         '613-555-0306'),
(23, 3, 'Hyatt Centric Montreal',      4, '1415 Rue de la Montagne, Montreal, QC','Montreal', 'montreal@hyatt.com',       '514-555-0307'),
(24, 3, 'Hyatt Place Kingston',        1, '1 Johnson St, Kingston, ON',         'Kingston',   'kingston@hyatt.com',       '613-555-0308');

-- Wyndham (chain_id=4): categories 2,3,1,2,3,4,2,3
INSERT INTO hotel (hotel_id, chain_id, name, category, address, area, contact_email, contact_phone) VALUES
(25, 4, 'Wyndham Garden Toronto',      2, '30 Carlton St, Toronto, ON',         'Toronto',    'toronto@wyndham.com',      '416-555-0401'),
(26, 4, 'Wyndham Winnipeg',            3, '360 Colony St, Winnipeg, MB',        'Winnipeg',   'winnipeg@wyndham.com',     '204-555-0402'),
(27, 4, 'Wyndham Thunder Bay',         1, '698 Arthur St W, Thunder Bay, ON',   'Thunder Bay','thunderbay@wyndham.com',   '807-555-0403'),
(28, 4, 'Wyndham Regina',              2, '1818 Victoria Ave, Regina, SK',      'Regina',     'regina@wyndham.com',       '306-555-0404'),
(29, 4, 'Wyndham Saskatoon',           3, '405 20th St E, Saskatoon, SK',       'Saskatoon',  'saskatoon@wyndham.com',    '306-555-0405'),
(30, 4, 'Wyndham Halifax Waterfront',  4, '1980 Robie St, Halifax, NS',         'Halifax',    'halifax@wyndham.com',      '902-555-0406'),
(31, 4, 'Wyndham Hamilton',            2, '150 King St E, Hamilton, ON',        'Hamilton',   'hamilton@wyndham.com',     '905-555-0407'),
(32, 4, 'Wyndham Ottawa West',         3, '350 Moodie Dr, Ottawa, ON',          'Ottawa',     'ottawa@wyndham.com',       '613-555-0408');

-- IHG (chain_id=5): categories 3,4,5,2,3,4,1,5
INSERT INTO hotel (hotel_id, chain_id, name, category, address, area, contact_email, contact_phone) VALUES
(33, 5, 'Holiday Inn Toronto Yorkdale', 3, '3450 Dufferin St, Toronto, ON',     'Toronto',    'yorkdale@ihg.com',         '416-555-0501'),
(34, 5, 'Crowne Plaza Montreal',        4, '505 Sherbrooke St E, Montreal, QC',  'Montreal',   'montreal@ihg.com',         '514-555-0502'),
(35, 5, 'InterContinental Vancouver',   5, '1300 Robson St, Vancouver, BC',      'Vancouver',  'vancouver@ihg.com',        '604-555-0503'),
(36, 5, 'Holiday Inn Express Surrey',   2, '10720 King George Blvd, Surrey, BC', 'Surrey',     'surrey@ihg.com',           '604-555-0504'),
(37, 5, 'Holiday Inn Calgary South',    3, '4206 Macleod Trail S, Calgary, AB',  'Calgary',    'calgary@ihg.com',          '403-555-0505'),
(38, 5, 'Crowne Plaza Ottawa',          4, '101 Lyon St N, Ottawa, ON',          'Ottawa',     'ottawa@ihg.com',           '613-555-0506'),
(39, 5, 'Holiday Inn Express Moncton',  1, '2515 Mountain Rd, Moncton, NB',     'Moncton',    'moncton@ihg.com',          '506-555-0507'),
(40, 5, 'InterContinental Toronto',     5, '225 Front St W, Toronto, ON',        'Toronto',    'toronto@ihg.com',          '416-555-0508');

SELECT setval('hotel_hotel_id_seq', 40);

-- 3. Employees (~80, 2 per hotel)
INSERT INTO employee (employee_id, hotel_id, full_name, address, ssn_sin) VALUES
-- Marriott employees (hotels 1-8)
(1,  1, 'James Wilson',       '12 Maple Ave, Toronto, ON',       '100-100-100'),
(2,  1, 'Sarah Chen',         '34 Oak St, Toronto, ON',          '100-100-101'),
(3,  2, 'Michael Brown',      '56 Elgin St, Ottawa, ON',         '100-100-102'),
(4,  2, 'Emily Davis',        '78 Bank St, Ottawa, ON',          '100-100-103'),
(5,  3, 'David Kim',          '90 Denman St, Vancouver, BC',     '100-100-104'),
(6,  3, 'Jennifer Lee',       '22 Davie St, Vancouver, BC',      '100-100-105'),
(7,  4, 'Robert Taylor',      '44 Centre St N, Calgary, AB',     '100-100-106'),
(8,  4, 'Lisa Anderson',      '66 Kensington Rd, Calgary, AB',   '100-100-107'),
(9,  5, 'Daniel Martin',      '88 Sherbrooke St, Montreal, QC',   '100-100-108'),
(10, 5, 'Marie Tremblay',     '10 Saint-Denis St, Montreal, QC',  '100-100-109'),
(11, 6, 'Thomas White',       '32 Spring Garden Rd, Halifax, NS', '100-100-110'),
(12, 6, 'Karen Mitchell',     '54 Barrington St, Halifax, NS',    '100-100-111'),
(13, 7, 'Steven Clark',       '76 Portage Ave, Winnipeg, MB',     '100-100-112'),
(14, 7, 'Nancy Wright',       '98 Broadway Ave, Winnipeg, MB',    '100-100-113'),
(15, 8, 'Chris Robinson',     '11 Dixon Rd, Toronto, ON',         '100-100-114'),
(16, 8, 'Amanda Hall',        '33 Carlingview Dr, Toronto, ON',   '100-100-115'),

-- Hilton employees (hotels 9-16)
(17, 9,  'Brian Harris',      '55 King St W, Toronto, ON',        '200-200-200'),
(18, 9,  'Melissa Young',     '77 Queen St W, Toronto, ON',       '200-200-201'),
(19, 10, 'Patrick Gagnon',    '99 Grande Allee, Quebec, QC',      '200-200-202'),
(20, 10, 'Sophie Bouchard',   '21 Rue St-Jean, Quebec, QC',       '200-200-203'),
(21, 11, 'Mark Thompson',     '43 Jasper Ave, Edmonton, AB',      '200-200-204'),
(22, 11, 'Laura Scott',       '65 Whyte Ave, Edmonton, AB',       '200-200-205'),
(23, 12, 'Kevin Nguyen',      '87 Kingsway, Burnaby, BC',         '200-200-206'),
(24, 12, 'Diana Patel',       '09 Canada Way, Burnaby, BC',       '200-200-207'),
(25, 13, 'George Adams',      '31 Dundas St, London, ON',         '200-200-208'),
(26, 13, 'Rachel Green',      '53 Richmond St, London, ON',       '200-200-209'),
(27, 14, 'Alan Baker',        '75 Metcalfe St, Ottawa, ON',       '200-200-210'),
(28, 14, 'Catherine Roy',     '97 Laurier Ave, Ottawa, ON',       '200-200-211'),
(29, 15, 'Peter Lavoie',      '19 Peel St, Montreal, QC',         '200-200-212'),
(30, 15, 'Isabelle Cote',     '41 Crescent St, Montreal, QC',     '200-200-213'),
(31, 16, 'Frank Miller',      '63 Lundy Lane, Niagara Falls, ON', '200-200-214'),
(32, 16, 'Grace Park',        '85 Ferry St, Niagara Falls, ON',   '200-200-215'),

-- Hyatt employees (hotels 17-24)
(33, 17, 'Henry Jackson',     '17 Spadina Ave, Toronto, ON',      '300-300-300'),
(34, 17, 'Victoria Singh',    '39 Bathurst St, Toronto, ON',      '300-300-301'),
(35, 18, 'William Turner',    '51 Gateway Blvd, Edmonton, AB',    '300-300-302'),
(36, 18, 'Samantha Phillips', '73 109th St, Edmonton, AB',        '300-300-303'),
(37, 19, 'Joseph Campbell',   '95 4th Ave SW, Calgary, AB',       '300-300-304'),
(38, 19, 'Angela Stewart',    '17 17th Ave SW, Calgary, AB',      '300-300-305'),
(39, 20, 'Ryan Edwards',      '39 Hurontario St, Mississauga, ON','300-300-306'),
(40, 20, 'Nicole Collins',    '51 Dundas St W, Mississauga, ON',  '300-300-307'),
(41, 21, 'Eric Murphy',       '73 Robson St, Vancouver, BC',      '300-300-308'),
(42, 21, 'Stephanie Brooks',  '95 Granville St, Vancouver, BC',   '300-300-309'),
(43, 22, 'Jason Reed',        '17 Sparks St, Ottawa, ON',         '300-300-310'),
(44, 22, 'Michelle Simard',   '39 Rideau St, Ottawa, ON',         '300-300-311'),
(45, 23, 'Alexander Morin',   '51 Ste-Catherine St, Montreal, QC','300-300-312'),
(46, 23, 'Christine Fortin',  '73 St-Laurent Blvd, Montreal, QC', '300-300-313'),
(47, 24, 'Douglas Watson',    '95 Princess St, Kingston, ON',     '300-300-314'),
(48, 24, 'Rebecca James',     '17 Brock St, Kingston, ON',        '300-300-315'),

-- Wyndham employees (hotels 25-32)
(49, 25, 'Andrew Cooper',     '39 Yonge St, Toronto, ON',         '400-400-400'),
(50, 25, 'Megan Price',       '51 Bloor St E, Toronto, ON',       '400-400-401'),
(51, 26, 'Tyler Howard',      '73 Main St, Winnipeg, MB',         '400-400-402'),
(52, 26, 'Ashley Ward',       '95 Osborne St, Winnipeg, MB',      '400-400-403'),
(53, 27, 'Brandon Morris',    '17 May St N, Thunder Bay, ON',     '400-400-404'),
(54, 27, 'Tiffany Rogers',    '39 Red River Rd, Thunder Bay, ON', '400-400-405'),
(55, 28, 'Derek Hughes',      '51 Albert St, Regina, SK',         '400-400-406'),
(56, 28, 'Natalie Fisher',    '73 Broad St, Regina, SK',          '400-400-407'),
(57, 29, 'Cameron Long',      '95 Broadway Ave, Saskatoon, SK',   '400-400-408'),
(58, 29, 'Brittany Sanders',  '17 2nd Ave N, Saskatoon, SK',      '400-400-409'),
(59, 30, 'Austin Perry',      '39 Quinpool Rd, Halifax, NS',      '400-400-410'),
(60, 30, 'Kayla Russell',     '51 Gottingen St, Halifax, NS',     '400-400-411'),
(61, 31, 'Logan Butler',      '73 James St N, Hamilton, ON',      '400-400-412'),
(62, 31, 'Paige Griffin',     '95 King William St, Hamilton, ON',  '400-400-413'),
(63, 32, 'Nathan Diaz',       '17 Richmond Rd, Ottawa, ON',       '400-400-414'),
(64, 32, 'Hailey Barnes',     '39 Carling Ave, Ottawa, ON',       '400-400-415'),

-- IHG employees (hotels 33-40)
(65, 33, 'Ethan Foster',      '51 Wilson Ave, Toronto, ON',       '500-500-500'),
(66, 33, 'Olivia Hayes',      '73 Lawrence Ave W, Toronto, ON',   '500-500-501'),
(67, 34, 'Lucas Girard',      '95 St-Hubert St, Montreal, QC',    '500-500-502'),
(68, 34, 'Chloe Pelletier',   '17 Ontario St E, Montreal, QC',    '500-500-503'),
(69, 35, 'Mason Hunt',        '39 Thurlow St, Vancouver, BC',     '500-500-504'),
(70, 35, 'Ava Simmons',       '51 Hornby St, Vancouver, BC',      '500-500-505'),
(71, 36, 'Liam Chapman',      '73 Fraser Hwy, Surrey, BC',        '500-500-506'),
(72, 36, 'Emma Dunn',         '95 128th St, Surrey, BC',          '500-500-507'),
(73, 37, 'Noah Graham',       '17 Macleod Trail, Calgary, AB',    '500-500-508'),
(74, 37, 'Sophia Knight',     '39 Elbow Dr SW, Calgary, AB',      '500-500-509'),
(75, 38, 'Jacob Bergeron',    '51 Kent St, Ottawa, ON',           '500-500-510'),
(76, 38, 'Isabella Lefebvre', '73 Slater St, Ottawa, ON',         '500-500-511'),
(77, 39, 'Aiden MacDonald',   '95 Main St, Moncton, NB',          '500-500-512'),
(78, 39, 'Mia Sullivan',      '17 St George Blvd, Moncton, NB',   '500-500-513'),
(79, 40, 'Benjamin Carter',   '39 Front St W, Toronto, ON',       '500-500-514'),
(80, 40, 'Charlotte Wood',    '51 Simcoe St, Toronto, ON',        '500-500-515');

SELECT setval('employee_employee_id_seq', 80);

-- 4. Update hotels with manager_employee_id (first employee of each hotel)
UPDATE hotel SET manager_employee_id = 1  WHERE hotel_id = 1;
UPDATE hotel SET manager_employee_id = 3  WHERE hotel_id = 2;
UPDATE hotel SET manager_employee_id = 5  WHERE hotel_id = 3;
UPDATE hotel SET manager_employee_id = 7  WHERE hotel_id = 4;
UPDATE hotel SET manager_employee_id = 9  WHERE hotel_id = 5;
UPDATE hotel SET manager_employee_id = 11 WHERE hotel_id = 6;
UPDATE hotel SET manager_employee_id = 13 WHERE hotel_id = 7;
UPDATE hotel SET manager_employee_id = 15 WHERE hotel_id = 8;
UPDATE hotel SET manager_employee_id = 17 WHERE hotel_id = 9;
UPDATE hotel SET manager_employee_id = 19 WHERE hotel_id = 10;
UPDATE hotel SET manager_employee_id = 21 WHERE hotel_id = 11;
UPDATE hotel SET manager_employee_id = 23 WHERE hotel_id = 12;
UPDATE hotel SET manager_employee_id = 25 WHERE hotel_id = 13;
UPDATE hotel SET manager_employee_id = 27 WHERE hotel_id = 14;
UPDATE hotel SET manager_employee_id = 29 WHERE hotel_id = 15;
UPDATE hotel SET manager_employee_id = 31 WHERE hotel_id = 16;
UPDATE hotel SET manager_employee_id = 33 WHERE hotel_id = 17;
UPDATE hotel SET manager_employee_id = 35 WHERE hotel_id = 18;
UPDATE hotel SET manager_employee_id = 37 WHERE hotel_id = 19;
UPDATE hotel SET manager_employee_id = 39 WHERE hotel_id = 20;
UPDATE hotel SET manager_employee_id = 41 WHERE hotel_id = 21;
UPDATE hotel SET manager_employee_id = 43 WHERE hotel_id = 22;
UPDATE hotel SET manager_employee_id = 45 WHERE hotel_id = 23;
UPDATE hotel SET manager_employee_id = 47 WHERE hotel_id = 24;
UPDATE hotel SET manager_employee_id = 49 WHERE hotel_id = 25;
UPDATE hotel SET manager_employee_id = 51 WHERE hotel_id = 26;
UPDATE hotel SET manager_employee_id = 53 WHERE hotel_id = 27;
UPDATE hotel SET manager_employee_id = 55 WHERE hotel_id = 28;
UPDATE hotel SET manager_employee_id = 57 WHERE hotel_id = 29;
UPDATE hotel SET manager_employee_id = 59 WHERE hotel_id = 30;
UPDATE hotel SET manager_employee_id = 61 WHERE hotel_id = 31;
UPDATE hotel SET manager_employee_id = 63 WHERE hotel_id = 32;
UPDATE hotel SET manager_employee_id = 65 WHERE hotel_id = 33;
UPDATE hotel SET manager_employee_id = 67 WHERE hotel_id = 34;
UPDATE hotel SET manager_employee_id = 69 WHERE hotel_id = 35;
UPDATE hotel SET manager_employee_id = 71 WHERE hotel_id = 36;
UPDATE hotel SET manager_employee_id = 73 WHERE hotel_id = 37;
UPDATE hotel SET manager_employee_id = 75 WHERE hotel_id = 38;
UPDATE hotel SET manager_employee_id = 77 WHERE hotel_id = 39;
UPDATE hotel SET manager_employee_id = 79 WHERE hotel_id = 40;

-- 5. Employee Roles
INSERT INTO employee_role (role_id, name) VALUES
(1, 'Manager'),
(2, 'Receptionist'),
(3, 'Housekeeper'),
(4, 'Maintenance');

SELECT setval('employee_role_role_id_seq', 4);

-- 6. Employee Has Role (odd-numbered employees = Manager, even = mix of others)
INSERT INTO employee_has_role (employee_id, role_id) VALUES
-- Managers (first employee of each hotel)
(1, 1), (3, 1), (5, 1), (7, 1), (9, 1), (11, 1), (13, 1), (15, 1),
(17, 1), (19, 1), (21, 1), (23, 1), (25, 1), (27, 1), (29, 1), (31, 1),
(33, 1), (35, 1), (37, 1), (39, 1), (41, 1), (43, 1), (45, 1), (47, 1),
(49, 1), (51, 1), (53, 1), (55, 1), (57, 1), (59, 1), (61, 1), (63, 1),
(65, 1), (67, 1), (69, 1), (71, 1), (73, 1), (75, 1), (77, 1), (79, 1),
-- Receptionists
(2, 2), (4, 2), (6, 2), (10, 2), (14, 2), (18, 2), (22, 2), (26, 2),
(30, 2), (34, 2), (38, 2), (42, 2), (46, 2), (50, 2),
-- Housekeepers
(8, 3), (12, 3), (16, 3), (20, 3), (24, 3), (28, 3), (32, 3), (36, 3),
(40, 3), (44, 3), (48, 3), (52, 3), (56, 3), (60, 3),
-- Maintenance
(54, 4), (58, 4), (62, 4), (64, 4), (66, 4), (68, 4), (70, 4), (72, 4),
(74, 4), (76, 4), (78, 4), (80, 4);

-- 7. Customers (20)
INSERT INTO customer (customer_id, full_name, address, id_type, id_number, registration_date) VALUES
(1,  'John Smith',          '10 Elm St, Toronto, ON',          'passport',         'CA12345678',  '2025-06-15'),
(2,  'Maria Garcia',        '22 Pine Ave, Montreal, QC',       'driver_license',   'QC-G1234567', '2025-07-20'),
(3,  'Wei Zhang',           '34 Cedar Blvd, Vancouver, BC',    'passport',         'CN98765432',  '2025-08-10'),
(4,  'Priya Sharma',        '46 Birch Rd, Ottawa, ON',         'national_id',      'IN4567890123', '2025-09-01'),
(5,  'Ahmed Hassan',        '58 Spruce Ln, Calgary, AB',       'passport',         'EG11223344',  '2025-09-22'),
(6,  'Emma Johansson',      '70 Willow Dr, Edmonton, AB',      'driver_license',   'AB-D9876543', '2025-10-05'),
(7,  'Carlos Rodriguez',    '82 Aspen Way, Halifax, NS',       'passport',         'MX55667788',  '2025-10-30'),
(8,  'Yuki Tanaka',         '94 Poplar Cres, Winnipeg, MB',    'national_id',      'JP1122334455', '2025-11-12'),
(9,  'Sophie Dubois',       '106 Larch St, Quebec, QC',        'driver_license',   'QC-F7654321', '2025-11-28'),
(10, 'Raj Patel',           '118 Fir Ave, Mississauga, ON',    'passport',         'IN99887766',  '2025-12-03'),
(11, 'Anna Kowalski',       '130 Hemlock Rd, Hamilton, ON',    'national_id',      'PL5544332211', '2025-12-18'),
(12, 'Omar Ali',            '142 Juniper Blvd, London, ON',    'passport',         'SA33445566',  '2026-01-05'),
(13, 'Fatima Benali',       '154 Redwood Ln, Saskatoon, SK',   'driver_license',   'SK-H2345678', '2026-01-20'),
(14, 'Liam O''Brien',       '166 Chestnut Dr, Kingston, ON',   'passport',         'IE77889900',  '2026-02-01'),
(15, 'Hiroshi Yamamoto',    '178 Magnolia Way, Surrey, BC',    'national_id',      'JP6677889900', '2026-02-14'),
(16, 'Elena Volkov',        '190 Sycamore Cres, Regina, SK',   'passport',         'RU11224466',  '2026-02-28'),
(17, 'David Tremblay',      '202 Alder St, Moncton, NB',       'driver_license',   'NB-C8765432', '2026-03-10'),
(18, 'Nina Johal',          '214 Cypress Ave, Niagara Falls, ON','passport',        'CA87654321',  '2026-03-15'),
(19, 'Lucas Bergeron',      '226 Walnut Rd, Thunder Bay, ON',  'driver_license',   'ON-E3456789', '2026-03-22'),
(20, 'Aisha Mohammed',      '238 Ivy Blvd, Toronto, ON',       'national_id',      'CA2233445566','2026-03-30');

SELECT setval('customer_customer_id_seq', 20);

-- 8. Rooms (5 per hotel = 200 total)
-- Hotel 1 - Marriott Downtown Toronto (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(1,  1, '101', 'single', 180.00, 'city',     false, NULL),
(2,  1, '102', 'double', 250.00, 'city',     true,  NULL),
(3,  1, '201', 'double', 280.00, 'city',     true,  'Minor paint chipping'),
(4,  1, '301', 'triple', 350.00, 'city',     false, NULL),
(5,  1, '401', 'quad',   400.00, 'city',     true,  NULL);

-- Hotel 2 - Marriott Ottawa Rideau (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(6,  2, '101', 'single', 150.00, 'city',     false, NULL),
(7,  2, '102', 'double', 200.00, 'city',     true,  NULL),
(8,  2, '201', 'double', 220.00, 'none',     false, 'Slow drain in bathroom'),
(9,  2, '202', 'triple', 280.00, 'city',     true,  NULL),
(10, 2, '301', 'quad',   340.00, 'city',     false, NULL);

-- Hotel 3 - Marriott Vancouver Waterfront (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(11, 3, '101', 'single', 200.00, 'sea',      false, NULL),
(12, 3, '102', 'double', 300.00, 'sea',      true,  NULL),
(13, 3, '201', 'double', 280.00, 'mountain', true,  NULL),
(14, 3, '301', 'triple', 370.00, 'sea',      false, NULL),
(15, 3, '401', 'quad',   400.00, 'mountain', true,  'AC unit noisy');

-- Hotel 4 - Marriott Calgary Airport (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(16, 4, '101', 'single', 95.00,  'none',     false, NULL),
(17, 4, '102', 'double', 140.00, 'mountain', true,  NULL),
(18, 4, '103', 'double', 140.00, 'none',     false, 'Stained carpet'),
(19, 4, '201', 'triple', 180.00, 'mountain', true,  NULL),
(20, 4, '202', 'quad',   220.00, 'mountain', false, NULL);

-- Hotel 5 - Marriott Montreal Centre (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(21, 5, '101', 'single', 160.00, 'city',     false, NULL),
(22, 5, '102', 'double', 220.00, 'city',     true,  NULL),
(23, 5, '201', 'triple', 290.00, 'city',     false, NULL),
(24, 5, '301', 'quad',   350.00, 'city',     true,  NULL),
(25, 5, '302', 'double', 210.00, 'none',     false, 'Window latch broken');

-- Hotel 6 - Marriott Halifax Harbour (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(26, 6, '101', 'single', 100.00, 'sea',      false, NULL),
(27, 6, '102', 'double', 150.00, 'sea',      true,  NULL),
(28, 6, '201', 'double', 140.00, 'city',     false, NULL),
(29, 6, '202', 'triple', 190.00, 'sea',      true,  NULL),
(30, 6, '301', 'quad',   230.00, 'sea',      false, 'Leaky faucet');

-- Hotel 7 - Marriott Winnipeg Downtown (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(31, 7, '101', 'single', 75.00,  'city',     false, NULL),
(32, 7, '102', 'double', 105.00, 'city',     true,  NULL),
(33, 7, '103', 'double', 100.00, 'none',     false, NULL),
(34, 7, '201', 'triple', 140.00, 'city',     false, 'Worn mattress'),
(35, 7, '202', 'quad',   170.00, 'city',     true,  NULL);

-- Hotel 8 - Marriott Toronto Airport (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(36, 8, '101', 'single', 110.00, 'none',     false, NULL),
(37, 8, '102', 'double', 155.00, 'none',     true,  NULL),
(38, 8, '201', 'double', 155.00, 'city',     false, NULL),
(39, 8, '202', 'triple', 200.00, 'city',     true,  NULL),
(40, 8, '301', 'quad',   250.00, 'city',     false, NULL);

-- Hotel 9 - Hilton Toronto Downtown (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(41, 9, '101', 'single', 160.00, 'city',     false, NULL),
(42, 9, '102', 'double', 230.00, 'city',     true,  NULL),
(43, 9, '201', 'double', 230.00, 'city',     true,  NULL),
(44, 9, '301', 'triple', 300.00, 'city',     false, 'Cracked mirror'),
(45, 9, '401', 'quad',   360.00, 'city',     true,  NULL);

-- Hotel 10 - Hilton Quebec City (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(46, 10, '101', 'single', 190.00, 'city',    false, NULL),
(47, 10, '102', 'double', 270.00, 'city',    true,  NULL),
(48, 10, '201', 'triple', 340.00, 'city',    false, NULL),
(49, 10, '301', 'quad',   400.00, 'city',    true,  NULL),
(50, 10, '302', 'double', 260.00, 'none',    false, NULL);

-- Hotel 11 - Hilton Edmonton (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(51, 11, '101', 'single', 100.00, 'city',     false, NULL),
(52, 11, '102', 'double', 150.00, 'city',     true,  NULL),
(53, 11, '103', 'double', 145.00, 'none',     false, 'Door squeaks'),
(54, 11, '201', 'triple', 195.00, 'city',     true,  NULL),
(55, 11, '202', 'quad',   240.00, 'city',     false, NULL);

-- Hotel 12 - Hilton Vancouver Metrotown (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(56, 12, '101', 'single', 155.00, 'mountain', false, NULL),
(57, 12, '102', 'double', 220.00, 'mountain', true,  NULL),
(58, 12, '201', 'double', 210.00, 'city',     false, NULL),
(59, 12, '301', 'triple', 280.00, 'mountain', true,  NULL),
(60, 12, '401', 'quad',   340.00, 'mountain', false, NULL);

-- Hotel 13 - Hilton London Ontario (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(61, 13, '101', 'single', 80.00,  'none',     false, NULL),
(62, 13, '102', 'double', 115.00, 'city',     true,  NULL),
(63, 13, '103', 'double', 110.00, 'none',     false, 'Toilet runs intermittently'),
(64, 13, '201', 'triple', 150.00, 'city',     false, NULL),
(65, 13, '202', 'quad',   180.00, 'city',     true,  NULL);

-- Hotel 14 - Hilton Ottawa Congress (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(66, 14, '101', 'single', 105.00, 'city',     false, NULL),
(67, 14, '102', 'double', 160.00, 'city',     true,  NULL),
(68, 14, '201', 'double', 155.00, 'none',     false, NULL),
(69, 14, '202', 'triple', 210.00, 'city',     true,  NULL),
(70, 14, '301', 'quad',   255.00, 'city',     false, NULL);

-- Hotel 15 - Hilton Montreal Bonaventure (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(71, 15, '101', 'single', 185.00, 'city',     false, NULL),
(72, 15, '102', 'double', 260.00, 'city',     true,  NULL),
(73, 15, '201', 'triple', 330.00, 'city',     true,  NULL),
(74, 15, '301', 'quad',   390.00, 'city',     false, NULL),
(75, 15, '302', 'double', 250.00, 'none',     false, 'Mini bar not cooling');

-- Hotel 16 - Hilton Niagara Falls (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(76, 16, '101', 'single', 145.00, 'city',     false, NULL),
(77, 16, '102', 'double', 210.00, 'sea',      true,  NULL),
(78, 16, '201', 'double', 220.00, 'sea',      true,  NULL),
(79, 16, '301', 'triple', 290.00, 'sea',      false, NULL),
(80, 16, '401', 'quad',   350.00, 'sea',      true,  NULL);

-- Hotel 17 - Hyatt Regency Toronto (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(81, 17, '101', 'single', 195.00, 'city',     false, NULL),
(82, 17, '102', 'double', 280.00, 'city',     true,  NULL),
(83, 17, '201', 'triple', 350.00, 'city',     true,  NULL),
(84, 17, '301', 'quad',   400.00, 'city',     false, NULL),
(85, 17, '302', 'double', 270.00, 'none',     false, 'Thermostat inaccurate');

-- Hotel 18 - Hyatt Place Edmonton (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(86, 18, '101', 'single', 95.00,  'city',     false, NULL),
(87, 18, '102', 'double', 145.00, 'city',     true,  NULL),
(88, 18, '103', 'double', 140.00, 'none',     false, NULL),
(89, 18, '201', 'triple', 185.00, 'city',     true,  NULL),
(90, 18, '202', 'quad',   225.00, 'city',     false, NULL);

-- Hotel 19 - Hyatt Regency Calgary (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(91, 19, '101', 'single', 150.00, 'mountain', false, NULL),
(92, 19, '102', 'double', 215.00, 'mountain', true,  NULL),
(93, 19, '201', 'double', 210.00, 'city',     false, NULL),
(94, 19, '301', 'triple', 280.00, 'mountain', true,  NULL),
(95, 19, '401', 'quad',   345.00, 'mountain', false, 'Shower head loose');

-- Hotel 20 - Hyatt Place Mississauga (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(96,  20, '101', 'single', 80.00,  'none',    false, NULL),
(97,  20, '102', 'double', 120.00, 'city',    true,  NULL),
(98,  20, '103', 'double', 115.00, 'none',    false, NULL),
(99,  20, '201', 'triple', 155.00, 'city',    false, NULL),
(100, 20, '202', 'quad',   185.00, 'city',    true,  NULL);

-- Hotel 21 - Hyatt Regency Vancouver (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(101, 21, '101', 'single', 210.00, 'sea',      false, NULL),
(102, 21, '102', 'double', 310.00, 'sea',      true,  NULL),
(103, 21, '201', 'double', 290.00, 'mountain', true,  NULL),
(104, 21, '301', 'triple', 380.00, 'sea',      false, NULL),
(105, 21, '401', 'quad',   400.00, 'sea',      true,  'Balcony railing loose');

-- Hotel 22 - Hyatt Place Ottawa (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(106, 22, '101', 'single', 105.00, 'city',     false, NULL),
(107, 22, '102', 'double', 155.00, 'city',     true,  NULL),
(108, 22, '201', 'double', 150.00, 'none',     false, NULL),
(109, 22, '202', 'triple', 200.00, 'city',     true,  NULL),
(110, 22, '301', 'quad',   245.00, 'city',     false, NULL);

-- Hotel 23 - Hyatt Centric Montreal (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(111, 23, '101', 'single', 155.00, 'city',     false, NULL),
(112, 23, '102', 'double', 225.00, 'city',     true,  NULL),
(113, 23, '201', 'double', 220.00, 'city',     false, NULL),
(114, 23, '301', 'triple', 295.00, 'city',     true,  NULL),
(115, 23, '401', 'quad',   355.00, 'city',     false, 'TV remote missing');

-- Hotel 24 - Hyatt Place Kingston (1-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(116, 24, '101', 'single', 75.00,  'none',     false, NULL),
(117, 24, '102', 'double', 95.00,  'none',     true,  NULL),
(118, 24, '103', 'double', 90.00,  'city',     false, 'Peeling wallpaper'),
(119, 24, '201', 'triple', 120.00, 'city',     false, NULL),
(120, 24, '202', 'quad',   150.00, 'city',     true,  NULL);

-- Hotel 25 - Wyndham Garden Toronto (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(121, 25, '101', 'single', 85.00,  'city',     false, NULL),
(122, 25, '102', 'double', 120.00, 'city',     true,  NULL),
(123, 25, '103', 'double', 115.00, 'none',     false, NULL),
(124, 25, '201', 'triple', 155.00, 'city',     false, NULL),
(125, 25, '202', 'quad',   185.00, 'city',     true,  NULL);

-- Hotel 26 - Wyndham Winnipeg (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(126, 26, '101', 'single', 95.00,  'city',     false, NULL),
(127, 26, '102', 'double', 140.00, 'city',     true,  NULL),
(128, 26, '103', 'double', 135.00, 'none',     false, NULL),
(129, 26, '201', 'triple', 180.00, 'city',     true,  'Light fixture flickering'),
(130, 26, '202', 'quad',   220.00, 'city',     false, NULL);

-- Hotel 27 - Wyndham Thunder Bay (1-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(131, 27, '101', 'single', 75.00,  'none',     false, NULL),
(132, 27, '102', 'double', 95.00,  'none',     true,  NULL),
(133, 27, '103', 'double', 90.00,  'none',     false, 'Bathroom fan broken'),
(134, 27, '201', 'triple', 115.00, 'city',     false, NULL),
(135, 27, '202', 'quad',   140.00, 'city',     true,  NULL);

-- Hotel 28 - Wyndham Regina (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(136, 28, '101', 'single', 80.00,  'city',     false, NULL),
(137, 28, '102', 'double', 110.00, 'city',     true,  NULL),
(138, 28, '103', 'double', 105.00, 'none',     false, NULL),
(139, 28, '201', 'triple', 145.00, 'city',     false, NULL),
(140, 28, '202', 'quad',   175.00, 'city',     true,  NULL);

-- Hotel 29 - Wyndham Saskatoon (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(141, 29, '101', 'single', 90.00,  'city',     false, NULL),
(142, 29, '102', 'double', 135.00, 'city',     true,  NULL),
(143, 29, '103', 'double', 130.00, 'none',     false, NULL),
(144, 29, '201', 'triple', 175.00, 'city',     true,  NULL),
(145, 29, '202', 'quad',   215.00, 'city',     false, NULL);

-- Hotel 30 - Wyndham Halifax Waterfront (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(146, 30, '101', 'single', 140.00, 'sea',      false, NULL),
(147, 30, '102', 'double', 200.00, 'sea',      true,  NULL),
(148, 30, '201', 'double', 190.00, 'city',     false, 'Curtain rod bent'),
(149, 30, '301', 'triple', 260.00, 'sea',      true,  NULL),
(150, 30, '401', 'quad',   320.00, 'sea',      false, NULL);

-- Hotel 31 - Wyndham Hamilton (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(151, 31, '101', 'single', 80.00,  'city',     false, NULL),
(152, 31, '102', 'double', 115.00, 'city',     true,  NULL),
(153, 31, '103', 'double', 110.00, 'none',     false, NULL),
(154, 31, '201', 'triple', 150.00, 'city',     false, NULL),
(155, 31, '202', 'quad',   180.00, 'city',     true,  NULL);

-- Hotel 32 - Wyndham Ottawa West (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(156, 32, '101', 'single', 100.00, 'none',     false, NULL),
(157, 32, '102', 'double', 150.00, 'city',     true,  NULL),
(158, 32, '103', 'double', 145.00, 'none',     false, NULL),
(159, 32, '201', 'triple', 195.00, 'city',     true,  NULL),
(160, 32, '202', 'quad',   240.00, 'city',     false, NULL);

-- Hotel 33 - Holiday Inn Toronto Yorkdale (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(161, 33, '101', 'single', 95.00,  'city',     false, NULL),
(162, 33, '102', 'double', 140.00, 'city',     true,  NULL),
(163, 33, '103', 'double', 135.00, 'none',     false, NULL),
(164, 33, '201', 'triple', 180.00, 'city',     false, NULL),
(165, 33, '202', 'quad',   220.00, 'city',     true,  NULL);

-- Hotel 34 - Crowne Plaza Montreal (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(166, 34, '101', 'single', 150.00, 'city',     false, NULL),
(167, 34, '102', 'double', 215.00, 'city',     true,  NULL),
(168, 34, '201', 'double', 210.00, 'city',     false, 'Desk lamp not working'),
(169, 34, '301', 'triple', 280.00, 'city',     true,  NULL),
(170, 34, '401', 'quad',   340.00, 'city',     false, NULL);

-- Hotel 35 - InterContinental Vancouver (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(171, 35, '101', 'single', 200.00, 'sea',      false, NULL),
(172, 35, '102', 'double', 295.00, 'sea',      true,  NULL),
(173, 35, '201', 'double', 275.00, 'mountain', true,  NULL),
(174, 35, '301', 'triple', 365.00, 'sea',      false, NULL),
(175, 35, '401', 'quad',   400.00, 'mountain', true,  NULL);

-- Hotel 36 - Holiday Inn Express Surrey (2-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(176, 36, '101', 'single', 80.00,  'none',     false, NULL),
(177, 36, '102', 'double', 115.00, 'city',     true,  NULL),
(178, 36, '103', 'double', 110.00, 'none',     false, NULL),
(179, 36, '201', 'triple', 150.00, 'city',     false, NULL),
(180, 36, '202', 'quad',   180.00, 'city',     true,  'Closet door off track');

-- Hotel 37 - Holiday Inn Calgary South (3-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(181, 37, '101', 'single', 100.00, 'mountain', false, NULL),
(182, 37, '102', 'double', 150.00, 'mountain', true,  NULL),
(183, 37, '103', 'double', 145.00, 'none',     false, NULL),
(184, 37, '201', 'triple', 195.00, 'mountain', true,  NULL),
(185, 37, '202', 'quad',   240.00, 'mountain', false, NULL);

-- Hotel 38 - Crowne Plaza Ottawa (4-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(186, 38, '101', 'single', 145.00, 'city',     false, NULL),
(187, 38, '102', 'double', 210.00, 'city',     true,  NULL),
(188, 38, '201', 'double', 205.00, 'city',     false, NULL),
(189, 38, '301', 'triple', 275.00, 'city',     true,  NULL),
(190, 38, '401', 'quad',   335.00, 'city',     false, 'Safe not locking');

-- Hotel 39 - Holiday Inn Express Moncton (1-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(191, 39, '101', 'single', 75.00,  'none',     false, NULL),
(192, 39, '102', 'double', 95.00,  'none',     true,  NULL),
(193, 39, '103', 'double', 90.00,  'city',     false, NULL),
(194, 39, '201', 'triple', 120.00, 'city',     false, NULL),
(195, 39, '202', 'quad',   145.00, 'city',     true,  NULL);

-- Hotel 40 - InterContinental Toronto (5-star)
INSERT INTO room (room_id, hotel_id, room_number, capacity, price, view_type, extendable, problems) VALUES
(196, 40, '101', 'single', 190.00, 'city',     false, NULL),
(197, 40, '102', 'double', 275.00, 'city',     true,  NULL),
(198, 40, '201', 'triple', 345.00, 'city',     true,  NULL),
(199, 40, '301', 'quad',   395.00, 'city',     false, NULL),
(200, 40, '302', 'double', 265.00, 'sea',      false, 'Outlet not working near bed');

SELECT setval('room_room_id_seq', 200);

-- 9. Amenities
INSERT INTO amenity (amenity_id, name) VALUES
(1, 'WiFi'),
(2, 'TV'),
(3, 'Air Conditioning'),
(4, 'Mini Bar'),
(5, 'Balcony'),
(6, 'Room Service');

SELECT setval('amenity_amenity_id_seq', 6);

-- 10. Room Amenities (2-4 per room)
-- All rooms get WiFi and TV; higher-end rooms get more amenities
INSERT INTO room_amenity (room_id, amenity_id) VALUES
-- Hotel 1 (5-star): all rooms get WiFi, TV, AC; suites get more
(1,1),(1,2),(1,3),
(2,1),(2,2),(2,3),(2,4),
(3,1),(3,2),(3,3),(3,6),
(4,1),(4,2),(4,3),(4,4),(4,6),
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),
-- Hotel 2 (4-star)
(6,1),(6,2),(6,3),
(7,1),(7,2),(7,3),(7,4),
(8,1),(8,2),(8,3),
(9,1),(9,2),(9,3),(9,6),
(10,1),(10,2),(10,3),(10,4),
-- Hotel 3 (5-star)
(11,1),(11,2),(11,3),(11,5),
(12,1),(12,2),(12,3),(12,4),(12,5),
(13,1),(13,2),(13,3),(13,5),
(14,1),(14,2),(14,3),(14,4),(14,5),(14,6),
(15,1),(15,2),(15,3),(15,5),(15,6),
-- Hotel 4 (3-star)
(16,1),(16,2),
(17,1),(17,2),(17,3),
(18,1),(18,2),(18,3),
(19,1),(19,2),(19,3),(19,6),
(20,1),(20,2),(20,3),
-- Hotel 5 (4-star)
(21,1),(21,2),(21,3),
(22,1),(22,2),(22,3),(22,4),
(23,1),(23,2),(23,3),(23,6),
(24,1),(24,2),(24,3),(24,4),(24,5),(24,6),
(25,1),(25,2),(25,3),
-- Hotel 6 (3-star)
(26,1),(26,2),(26,3),
(27,1),(27,2),(27,3),(27,5),
(28,1),(28,2),(28,3),
(29,1),(29,2),(29,3),(29,5),
(30,1),(30,2),(30,3),
-- Hotel 7 (2-star)
(31,1),(31,2),
(32,1),(32,2),(32,3),
(33,1),(33,2),
(34,1),(34,2),(34,3),
(35,1),(35,2),(35,3),
-- Hotel 8 (3-star)
(36,1),(36,2),(36,3),
(37,1),(37,2),(37,3),
(38,1),(38,2),(38,3),
(39,1),(39,2),(39,3),(39,6),
(40,1),(40,2),(40,3),(40,6),
-- Hotel 9 (4-star)
(41,1),(41,2),(41,3),
(42,1),(42,2),(42,3),(42,4),
(43,1),(43,2),(43,3),(43,6),
(44,1),(44,2),(44,3),(44,4),
(45,1),(45,2),(45,3),(45,4),(45,5),(45,6),
-- Hotel 10 (5-star)
(46,1),(46,2),(46,3),(46,6),
(47,1),(47,2),(47,3),(47,4),(47,6),
(48,1),(48,2),(48,3),(48,4),(48,6),
(49,1),(49,2),(49,3),(49,4),(49,5),(49,6),
(50,1),(50,2),(50,3),
-- Hotel 11 (3-star)
(51,1),(51,2),(51,3),
(52,1),(52,2),(52,3),
(53,1),(53,2),
(54,1),(54,2),(54,3),(54,6),
(55,1),(55,2),(55,3),
-- Hotel 12 (4-star)
(56,1),(56,2),(56,3),(56,5),
(57,1),(57,2),(57,3),(57,4),(57,5),
(58,1),(58,2),(58,3),
(59,1),(59,2),(59,3),(59,5),(59,6),
(60,1),(60,2),(60,3),(60,4),
-- Hotel 13 (2-star)
(61,1),(61,2),
(62,1),(62,2),(62,3),
(63,1),(63,2),
(64,1),(64,2),(64,3),
(65,1),(65,2),(65,3),
-- Hotel 14 (3-star)
(66,1),(66,2),(66,3),
(67,1),(67,2),(67,3),
(68,1),(68,2),
(69,1),(69,2),(69,3),(69,6),
(70,1),(70,2),(70,3),
-- Hotel 15 (5-star)
(71,1),(71,2),(71,3),(71,6),
(72,1),(72,2),(72,3),(72,4),(72,6),
(73,1),(73,2),(73,3),(73,4),(73,5),(73,6),
(74,1),(74,2),(74,3),(74,4),(74,5),(74,6),
(75,1),(75,2),(75,3),
-- Hotel 16 (4-star)
(76,1),(76,2),(76,3),
(77,1),(77,2),(77,3),(77,5),
(78,1),(78,2),(78,3),(78,5),
(79,1),(79,2),(79,3),(79,4),(79,5),
(80,1),(80,2),(80,3),(80,4),(80,5),(80,6),
-- Hotel 17 (5-star)
(81,1),(81,2),(81,3),(81,6),
(82,1),(82,2),(82,3),(82,4),(82,6),
(83,1),(83,2),(83,3),(83,4),(83,5),(83,6),
(84,1),(84,2),(84,3),(84,4),(84,5),(84,6),
(85,1),(85,2),(85,3),
-- Hotel 18 (3-star)
(86,1),(86,2),(86,3),
(87,1),(87,2),(87,3),
(88,1),(88,2),
(89,1),(89,2),(89,3),(89,6),
(90,1),(90,2),(90,3),
-- Hotel 19 (4-star)
(91,1),(91,2),(91,3),(91,5),
(92,1),(92,2),(92,3),(92,4),(92,5),
(93,1),(93,2),(93,3),
(94,1),(94,2),(94,3),(94,5),(94,6),
(95,1),(95,2),(95,3),(95,4),
-- Hotel 20 (2-star)
(96,1),(96,2),
(97,1),(97,2),(97,3),
(98,1),(98,2),
(99,1),(99,2),(99,3),
(100,1),(100,2),(100,3),
-- Hotel 21 (5-star)
(101,1),(101,2),(101,3),(101,5),
(102,1),(102,2),(102,3),(102,4),(102,5),(102,6),
(103,1),(103,2),(103,3),(103,5),
(104,1),(104,2),(104,3),(104,4),(104,5),(104,6),
(105,1),(105,2),(105,3),(105,4),(105,5),(105,6),
-- Hotel 22 (3-star)
(106,1),(106,2),(106,3),
(107,1),(107,2),(107,3),
(108,1),(108,2),
(109,1),(109,2),(109,3),(109,6),
(110,1),(110,2),(110,3),
-- Hotel 23 (4-star)
(111,1),(111,2),(111,3),
(112,1),(112,2),(112,3),(112,4),
(113,1),(113,2),(113,3),(113,6),
(114,1),(114,2),(114,3),(114,4),(114,6),
(115,1),(115,2),(115,3),(115,4),
-- Hotel 24 (1-star)
(116,1),(116,2),
(117,1),(117,2),
(118,1),(118,2),
(119,1),(119,2),(119,3),
(120,1),(120,2),(120,3),
-- Hotel 25 (2-star)
(121,1),(121,2),
(122,1),(122,2),(122,3),
(123,1),(123,2),
(124,1),(124,2),(124,3),
(125,1),(125,2),(125,3),
-- Hotel 26 (3-star)
(126,1),(126,2),(126,3),
(127,1),(127,2),(127,3),
(128,1),(128,2),
(129,1),(129,2),(129,3),(129,6),
(130,1),(130,2),(130,3),
-- Hotel 27 (1-star)
(131,1),(131,2),
(132,1),(132,2),
(133,1),(133,2),
(134,1),(134,2),(134,3),
(135,1),(135,2),(135,3),
-- Hotel 28 (2-star)
(136,1),(136,2),
(137,1),(137,2),(137,3),
(138,1),(138,2),
(139,1),(139,2),(139,3),
(140,1),(140,2),(140,3),
-- Hotel 29 (3-star)
(141,1),(141,2),(141,3),
(142,1),(142,2),(142,3),
(143,1),(143,2),
(144,1),(144,2),(144,3),(144,6),
(145,1),(145,2),(145,3),
-- Hotel 30 (4-star)
(146,1),(146,2),(146,3),(146,5),
(147,1),(147,2),(147,3),(147,4),(147,5),
(148,1),(148,2),(148,3),
(149,1),(149,2),(149,3),(149,5),(149,6),
(150,1),(150,2),(150,3),(150,4),
-- Hotel 31 (2-star)
(151,1),(151,2),
(152,1),(152,2),(152,3),
(153,1),(153,2),
(154,1),(154,2),(154,3),
(155,1),(155,2),(155,3),
-- Hotel 32 (3-star)
(156,1),(156,2),(156,3),
(157,1),(157,2),(157,3),
(158,1),(158,2),
(159,1),(159,2),(159,3),(159,6),
(160,1),(160,2),(160,3),
-- Hotel 33 (3-star)
(161,1),(161,2),(161,3),
(162,1),(162,2),(162,3),
(163,1),(163,2),
(164,1),(164,2),(164,3),(164,6),
(165,1),(165,2),(165,3),
-- Hotel 34 (4-star)
(166,1),(166,2),(166,3),
(167,1),(167,2),(167,3),(167,4),
(168,1),(168,2),(168,3),(168,6),
(169,1),(169,2),(169,3),(169,4),(169,6),
(170,1),(170,2),(170,3),(170,4),
-- Hotel 35 (5-star)
(171,1),(171,2),(171,3),(171,5),
(172,1),(172,2),(172,3),(172,4),(172,5),(172,6),
(173,1),(173,2),(173,3),(173,5),
(174,1),(174,2),(174,3),(174,4),(174,5),(174,6),
(175,1),(175,2),(175,3),(175,4),(175,5),(175,6),
-- Hotel 36 (2-star)
(176,1),(176,2),
(177,1),(177,2),(177,3),
(178,1),(178,2),
(179,1),(179,2),(179,3),
(180,1),(180,2),(180,3),
-- Hotel 37 (3-star)
(181,1),(181,2),(181,3),
(182,1),(182,2),(182,3),
(183,1),(183,2),
(184,1),(184,2),(184,3),(184,6),
(185,1),(185,2),(185,3),
-- Hotel 38 (4-star)
(186,1),(186,2),(186,3),
(187,1),(187,2),(187,3),(187,4),
(188,1),(188,2),(188,3),(188,6),
(189,1),(189,2),(189,3),(189,4),(189,6),
(190,1),(190,2),(190,3),(190,4),
-- Hotel 39 (1-star)
(191,1),(191,2),
(192,1),(192,2),
(193,1),(193,2),
(194,1),(194,2),(194,3),
(195,1),(195,2),(195,3),
-- Hotel 40 (5-star)
(196,1),(196,2),(196,3),(196,6),
(197,1),(197,2),(197,3),(197,4),(197,6),
(198,1),(198,2),(198,3),(198,4),(198,5),(198,6),
(199,1),(199,2),(199,3),(199,4),(199,5),(199,6),
(200,1),(200,2),(200,3);

-- 11. Bookings (~20, various statuses, dates around 2026)
INSERT INTO booking (booking_id, customer_id, room_id, start_date, end_date, status) VALUES
(1,  1,  2,  '2026-04-10', '2026-04-14', 'active'),
(2,  2,  12, '2026-04-15', '2026-04-18', 'active'),
(3,  3,  42, '2026-05-01', '2026-05-05', 'active'),
(4,  4,  82, '2026-05-10', '2026-05-13', 'active'),
(5,  5,  92, '2026-06-01', '2026-06-04', 'active'),
(6,  6,  102,'2026-06-15', '2026-06-20', 'active'),
(7,  7,  147,'2026-07-01', '2026-07-05', 'active'),
(8,  8,  32, '2026-04-08', '2026-04-11', 'cancelled'),
(9,  9,  47, '2026-04-20', '2026-04-23', 'cancelled'),
(10, 10, 97, '2026-05-05', '2026-05-08', 'cancelled'),
(11, 11, 62, '2026-03-01', '2026-03-04', 'rented'),
(12, 12, 112,'2026-03-05', '2026-03-09', 'rented'),
(13, 13, 142,'2026-03-10', '2026-03-13', 'rented'),
(14, 14, 167,'2026-03-15', '2026-03-18', 'rented'),
(15, 15, 172,'2026-03-20', '2026-03-24', 'rented'),
(16, 16, 137,'2026-07-10', '2026-07-14', 'active'),
(17, 17, 192,'2026-07-20', '2026-07-23', 'active'),
(18, 18, 77, '2026-08-01', '2026-08-05', 'active'),
(19, 19, 132,'2026-08-10', '2026-08-13', 'active'),
(20, 20, 197,'2026-08-15', '2026-08-20', 'active');

SELECT setval('booking_booking_id_seq', 20);

-- 12. Rentings (~15, some from bookings, some walk-in)
INSERT INTO renting (renting_id, customer_id, room_id, employee_id, booking_id, start_date, end_date, status) VALUES
-- From bookings (booking status = 'rented')
(1,  11, 62,  25, 11, '2026-03-01', '2026-03-04', 'completed'),
(2,  12, 112, 45, 12, '2026-03-05', '2026-03-09', 'completed'),
(3,  13, 142, 57, 13, '2026-03-10', '2026-03-13', 'completed'),
(4,  14, 167, 67, 14, '2026-03-15', '2026-03-18', 'completed'),
(5,  15, 172, 69, 15, '2026-03-20', '2026-03-24', 'completed'),
-- Walk-in rentings (no booking)
(6,  1,  41,  17, NULL, '2026-02-10', '2026-02-13', 'completed'),
(7,  3,  81,  33, NULL, '2026-02-15', '2026-02-18', 'completed'),
(8,  5,  91,  37, NULL, '2026-02-20', '2026-02-23', 'completed'),
(9,  7,  26,  11, NULL, '2026-03-01', '2026-03-05', 'completed'),
(10, 9,  46,  19, NULL, '2026-03-08', '2026-03-11', 'completed'),
-- Active rentings
(11, 2,  22,  9,  NULL, '2026-04-01', '2026-04-06', 'active'),
(12, 4,  107, 43, NULL, '2026-04-02', '2026-04-07', 'active'),
(13, 6,  52,  21, NULL, '2026-04-03', '2026-04-08', 'active'),
(14, 10, 162, 65, NULL, '2026-04-04', '2026-04-09', 'active'),
(15, 20, 196, 79, NULL, '2026-04-05', '2026-04-10', 'active');

SELECT setval('renting_renting_id_seq', 15);

-- 13. Payments (~10)
INSERT INTO payment (payment_id, renting_id, amount, paid_at) VALUES
(1,  1,  345.00,  '2026-03-04 11:30:00'),
(2,  2,  900.00,  '2026-03-09 10:00:00'),
(3,  3,  405.00,  '2026-03-13 09:45:00'),
(4,  4,  645.00,  '2026-03-18 14:00:00'),
(5,  5,  1180.00, '2026-03-24 12:15:00'),
(6,  6,  480.00,  '2026-02-13 10:30:00'),
(7,  7,  585.00,  '2026-02-18 11:00:00'),
(8,  8,  450.00,  '2026-02-23 09:30:00'),
(9,  9,  400.00,  '2026-03-05 13:00:00'),
(10, 10, 570.00,  '2026-03-11 10:45:00');

SELECT setval('payment_payment_id_seq', 10);
