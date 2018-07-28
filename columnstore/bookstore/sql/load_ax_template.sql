    CREATE DATABASE IF NOT EXISTS %DB% CHARACTER SET = 'UTF8';

    DROP TABLE IF EXISTS  %DB%.Books;
    CREATE TABLE %DB%.Books ( 
    book_id BIGINT UNSIGNED NOT NULL,
    cover_price DECIMAL(7,2) NOT NULL, 
    isbn VARCHAR(255) NOT NULL,
    bookname VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL, 
    discount DECIMAL(7,2) NOT NULL)  
    engine=columnstore;


    DROP TABLE IF EXISTS  %DB%.Covers;
    CREATE TABLE %DB%.Covers ( 
    cover_id INTEGER NOT NULL, 
    image LONGBLOB NOT NULL,
    PRIMARY KEY(cover_id)) Engine = INNODB;

    DROP TABLE IF EXISTS  %DB%.TransactionTypes;
    CREATE TABLE %DB%.TransactionTypes ( 
    tr_type_id BIGINT UNSIGNED NOT NULL, 
    tr_type VARCHAR(50) NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.MaritalStatuses;
    CREATE TABLE %DB%.MaritalStatuses ( 
    ms_id BIGINT UNSIGNED NOT NULL, 
    ms_type VARCHAR(50) NOT NULL)
    engine=columnstore;


    DROP TABLE IF EXISTS  %DB%.Cards;
    CREATE TABLE %DB%.Cards ( 
    card_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL, 
    card_nm VARCHAR(255) NOT NULL,
    card_type VARCHAR(255) NOT NULL,
    discount VARCHAR(255) NOT NULL, 
    points INTEGER NOT NULL,
    is_threshold TINYINT NOT NULL,
    award_percent DECIMAL(3,2) NOT NULL  
    )  
    engine=columnstore;


    DROP TABLE IF EXISTS  %DB%.Emails;
    CREATE TABLE %DB%.Emails ( 
    email_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL, 
    email_adr VARCHAR(255) NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.Phones;
    CREATE TABLE %DB%.Phones ( 
    phone_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL, 
    phone_nm VARCHAR(255) NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.Addresses;
    CREATE TABLE %DB%.Addresses ( 
    address_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL, 
    address VARCHAR(255) NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.Transactions;
    CREATE TABLE %DB%.Transactions ( 
    trans_date DATETIME NOT NULL,
    order_id BIGINT UNSIGNED NOT NULL,
    transaction_id BIGINT UNSIGNED NOT NULL,
    book_id INTEGER UNSIGNED NOT NULL,
    price DECIMAL(7,2) NOT NULL, 
    discount DECIMAL(7,2) NOT NULL, 
    discounted_price DECIMAL(7,2) NOT NULL, 
    transaction_type INTEGER NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.LoyaltyPoints;
    CREATE TABLE %DB%.LoyaltyPoints ( 
    trans_date DATETIME NOT NULL,
    order_id BIGINT UNSIGNED NOT NULL,
    card_is BIGINT UNSIGNED NOT NULL,
    points INTEGER NOT NULL, 
    customer_id BIGINT UNSIGNED NOT NULL)
    engine=columnstore;

    DROP TABLE IF EXISTS  %DB%.Customers;
    CREATE TABLE %DB%.Customers ( 
    customer_nm VARCHAR(512) NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    customer_username_nm VARCHAR(512) NOT NULL,
    sex CHAR(1) NOT NULL,
    age INTEGER NOT NULL,
    marital_status INTEGER NOT NULL)
    engine=columnstore;

    SELECT SLEEP(2) as '';
    SELECT 'Schema created.' as '';

    LOAD DATA LOCAL INFILE '%CSV%books.csv'
    INTO TABLE %DB%.Books
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Books') as '' FROM %DB%.Books;

    LOAD DATA LOCAL INFILE '%CSV%cards.csv'
    INTO TABLE %DB%.Cards
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;
    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Cards') as '' FROM %DB%.Cards;

    LOAD DATA LOCAL INFILE '%CSV%emails.csv'
    INTO TABLE %DB%.Emails
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Emails') as '' FROM %DB%.Emails;

    LOAD DATA LOCAL INFILE '%CSV%phones.csv'
    INTO TABLE %DB%.Phones
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Phones') as '' FROM %DB%.Phones;

    LOAD DATA LOCAL INFILE '%CSV%addresses.csv'
    INTO TABLE %DB%.Addresses
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Addresses') as '' FROM %DB%.Addresses;

    LOAD DATA LOCAL INFILE '%CSV%transactions.csv'
    INTO TABLE %DB%.Transactions
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Transactions') as '' FROM %DB%.Transactions;

    LOAD DATA LOCAL INFILE '%CSV%loaylty_points.csv'
    INTO TABLE %DB%.LoyaltyPoints
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in LoyaltyPoints') as '' FROM %DB%.LoyaltyPoints;

    LOAD DATA LOCAL INFILE '%CSV%customers.csv'
    INTO TABLE %DB%.Customers
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Customers') as '' FROM %DB%.Customers;

    LOAD DATA LOCAL INFILE '%CSV%covers.csv'
    INTO TABLE %DB%.Covers
    CHARACTER
    SET UTF8 FIELDS
    TERMINATED BY ','
    ENCLOSED BY ''''
    ESCAPED BY '\\' LINES TERMINATED BY '\n' IGNORE 0 LINES;

    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in Covers') as '' FROM %DB%.Covers;

    INSERT INTO %DB%.TransactionTypes (tr_type_id,tr_type) VALUES (1,'Item'), (2,'Discount'),(3,'Shipping');
    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in TransactionTypes') as '' FROM %DB%.TransactionTypes;

    INSERT INTO %DB%.MaritalStatuses (ms_id,ms_type) VALUES (1,'Never married'), (2,'Married'),(3,'Widow'),(4,'Separated'),(5,'Divorced');
    SELECT CONCAT('Loaded ',FORMAT(COUNT(*),0),' in MaritalStatuses') as '' FROM %DB%.MaritalStatuses;

