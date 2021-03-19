CREATE TABLE IF NOT EXISTS Organization (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(50)  NOT NULL           COMMENT 'Краткое наименование',
    full_name           VARCHAR(50)  NOT NULL           COMMENT 'Полное наименование',
    inn                 VARCHAR(12)  NOT NULL           COMMENT 'ИНН',
    kpp                 VARCHAR(9)   NOT NULL           COMMENT 'КПП',
    address             VARCHAR(255) NOT NULL           COMMENT 'Адрес',
    phone               VARCHAR(11)  NOT NULL           COMMENT 'Номер телефона',
    is_active           BOOLEAN                         COMMENT 'Действующая организация или нет'
);
CREATE INDEX IX_Organization_name ON Organization (name);
CREATE INDEX IX_Organization_inn ON Organization (inn);
CREATE INDEX IX_Organization_phone ON Organization (phone);

COMMENT ON TABLE Organization IS 'Таблица организаций';

CREATE TABLE IF NOT EXISTS Office (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255)  NOT NULL          COMMENT 'Наименование',
    address             VARCHAR(255) NOT NULL           COMMENT 'Адрес',
    phone               VARCHAR(11)  NOT NULL           COMMENT 'Номер телефона',
    is_active           BOOLEAN                         COMMENT 'Действующий офис или нет',
    organization_id     INTEGER                         COMMENT 'Внешний ключ на таблицу организации',
    FOREIGN KEY (organization_id) REFERENCES Organization(id)
);
CREATE INDEX IX_Office_name ON Office (name);
CREATE INDEX IX_Office_phone ON Office (phone);

COMMENT ON TABLE Office IS 'Таблица офисов организаций';

CREATE TABLE IF NOT EXISTS Document (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL           COMMENT 'Наименование',
    number              VARCHAR(25)  NOT NULL           COMMENT 'Номер',
    date                DATE         NOT NULL           COMMENT 'Дата'
);
CREATE INDEX IX_Document_number ON Document (number);

COMMENT ON TABLE Document IS 'Таблица документов';

CREATE TABLE IF NOT EXISTS Position (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL           COMMENT 'Наименование'
);
CREATE INDEX IX_Position_name ON Position (name);

COMMENT ON TABLE Position IS 'Таблица должностей';

CREATE TABLE IF NOT EXISTS Citizenship (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL           COMMENT 'Наименование',
    code                VARCHAR(255) NOT NULL           COMMENT 'Код'
);
CREATE INDEX IX_Citizenship_name ON Citizenship (name);
CREATE INDEX IX_Citizenship_code ON Citizenship (code);

COMMENT ON TABLE Citizenship IS 'Таблица Гражданства';

CREATE TABLE IF NOT EXISTS User (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    first_name          VARCHAR(60)  NOT NULL           COMMENT 'Имя',
    second_name         VARCHAR(60)  NOT NULL           COMMENT 'Фамилия',
    middle_name         VARCHAR(60)                     COMMENT 'Отчество',
    phone               VARCHAR(11)  NOT NULL           COMMENT 'Номер телефона',
    is_identified       BOOLEAN                         COMMENT 'Идентификация',
    position_id         INTEGER                         COMMENT 'Внешний ключ на таблицу должностей',
    office_id           INTEGER                         COMMENT 'Внешний ключ на таблицу офисов',
    document_id         INTEGER                         COMMENT 'Внешний ключ на таблицу документов',
    citizenship_id      INTEGER                         COMMENT 'Внешний ключ на таблицу гражданства',
    FOREIGN KEY (position_id) REFERENCES Position(id),
    FOREIGN KEY (office_id) REFERENCES Office(id),
    FOREIGN KEY (document_id) REFERENCES Document(id),
    FOREIGN KEY (citizenship_id) REFERENCES Citizenship(id)
);
CREATE INDEX IX_User_first_name ON User (first_name);
CREATE INDEX IX_User_second_name ON User (second_name);
CREATE INDEX IX_User_phone ON User (phone);
CREATE INDEX IX_User_office_id ON User (office_id);
CREATE INDEX IX_User_position_id ON User (position_id);

COMMENT ON TABLE User IS 'Таблица сотрудников';






