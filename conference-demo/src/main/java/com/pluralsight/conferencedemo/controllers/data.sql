CREATE TABLE attendees
(
    attendee_id  IDENTITY(1,1) PRIMARY KEY,
    first_name   varchar(30) NOT NULL,
    last_name    varchar(30) NOT NULL,
    title        varchar(40) NULL,
    company      varchar(50) NULL,
    email        varchar(80) NOT NULL,
    phone_number varchar(20) NULL
);

CREATE TABLE ticket_types
(
    ticket_type_code  varchar(1) PRIMARY KEY,
    ticket_type_name  varchar(30)  NOT NULL,
    description       varchar(100) NOT NULL,
    includes_workshop BIT      NOT NULL
);

CREATE TABLE pricing_categories
(
    pricing_category_code varchar(1) PRIMARY KEY,
    pricing_category_name varchar(20) NOT NULL,
    pricing_start_date    date        NOT NULL,
    pricing_end_date      date        NOT NULL
);

CREATE TABLE ticket_prices
(
    ticket_price_id       IDENTITY(1,1) PRIMARY KEY,
    ticket_type_code      varchar(1)    NOT NULL REFERENCES ticket_types (ticket_type_code),
    pricing_category_code varchar(1)    NOT NULL REFERENCES pricing_categories (pricing_category_code),
    base_price            numeric(8, 2) NOT NULL
);

CREATE TABLE discount_codes
(
    discount_code_id IDENTITY(1,1) PRIMARY KEY,
    discount_code    varchar(20)   NOT NULL,
    discount_name    varchar(30)   NOT NULL,
    discount_type    varchar(1)    NOT NULL,
    discount_amount  numeric(8, 2) NOT NULL
);

CREATE TABLE attendee_tickets
(
    attendee_ticket_id IDENTITY(1,1) PRIMARY KEY,
    attendee_id        integer       NOT NULL,
    ticket_price_id    integer       NOT NULL,
    discount_code_id   integer       NULL,
    net_price          numeric(8, 2) NOT NULL
);

CREATE TABLE time_slots
(
    time_slot_id         IDENTITY(1,1) PRIMARY KEY,
    time_slot_date       date                   NOT NULL,
    start_time           DATETIME2 NOT NULL,
    end_time             DATETIME2 NOT NULL,
    is_keynote_time_slot BIT
);

CREATE TABLE sessions
(
    session_id          IDENTITY(1,1) PRIMARY KEY,
    session_name        varchar(80)   NOT NULL,
    session_description varchar(1024) NOT NULL,
    session_length      integer       NOT NULL
);

CREATE TABLE session_schedule
(
    schedule_id  IDENTITY(1,1) PRIMARY KEY,
    time_slot_id integer     NOT NULL,
    session_id   integer     NOT NULL,
    room         varchar(30) NOT NULL
);

CREATE TABLE tags
(
    tag_id      IDENTITY(1,1) PRIMARY KEY,
    description varchar(30) NOT NULL
);

CREATE TABLE session_tags
(
    session_id integer NOT NULL ,
    tag_id     integer NOT NULL
);

CREATE TABLE speakers
(
    speaker_id    IDENTITY(1,1) PRIMARY KEY,
    first_name    varchar(30)   NOT NULL,
    last_name     varchar(30)   NOT NULL,
    title         varchar(40)   NOT NULL,
    company       varchar(50)   NOT NULL,
    speaker_bio   varchar(2000) NOT NULL,
    speaker_photo varbinary(1024)    NULL
);

CREATE TABLE session_speakers
(
    session_id integer NOT NULL ,
    speaker_id integer NOT NULL
);

CREATE TABLE workshops
(
    workshop_id   IDENTITY(1,1) PRIMARY KEY,
    workshop_name varchar(60)   NOT NULL,
    description   varchar(1024) NOT NULL,
    requirements  varchar(1024) NOT NULL,
    room          varchar(30)   NOT NULL,
    capacity      integer       NOT NULL
);

CREATE TABLE workshop_speakers
(
    workshop_id integer NOT NULL,
    speaker_id  integer NOT NULL
);

CREATE TABLE workshop_registrations
(
    workshop_id        integer NOT NULL,
    attendee_ticket_id integer NOT NULL
);
