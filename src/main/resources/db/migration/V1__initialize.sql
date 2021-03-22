CREATE TABLE IF NOT EXISTS Organization (
    id                  INTEGER                  COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL    COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL    COMMENT 'Краткое наименование',
    full_name           VARCHAR(255) NOT NULL    COMMENT 'Полное наименование',
    inn                 VARCHAR(12)  NOT NULL    COMMENT 'ИНН',
    kpp                 VARCHAR(9)   NOT NULL    COMMENT 'КПП',
    address             VARCHAR(255) NOT NULL    COMMENT 'Адрес',
    phone               VARCHAR(11)  NOT NULL    COMMENT 'Номер телефона',
    is_active           BOOLEAN                  COMMENT 'Действующая организация или нет'
);
CREATE INDEX IX_Organization_name ON Organization (name);

COMMENT ON TABLE Organization IS 'Таблица организаций';



CREATE TABLE IF NOT EXISTS Office (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL           COMMENT 'Наименование',
    address             VARCHAR(255) NOT NULL           COMMENT 'Адрес',
    phone               VARCHAR(11)  NOT NULL           COMMENT 'Номер телефона',
    is_active           BOOLEAN                         COMMENT 'Действующий офис или нет',
    organization_id     INTEGER      NOT NULL           COMMENT 'Внешний ключ на таблицу организации',
    FOREIGN KEY (organization_id) REFERENCES Organization(id)
);
CREATE INDEX IX_Office_organization_id ON Office (organization_id);

COMMENT ON TABLE Office IS 'Таблица офисов организаций';

CREATE TABLE IF NOT EXISTS Citizenship (
       id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
       version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
       name                VARCHAR(255) NOT NULL           COMMENT 'Наименование',
       code                VARCHAR(255) NOT NULL           COMMENT 'Код'
);
CREATE INDEX IX_Citizenship_code ON Citizenship(code);

COMMENT ON TABLE Citizenship IS 'Таблица Гражданства';

CREATE TABLE IF NOT EXISTS User (
        id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
        version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
        first_name          VARCHAR(60)  NOT NULL           COMMENT 'Имя',
        second_name         VARCHAR(60)  NOT NULL           COMMENT 'Фамилия',
        middle_name         VARCHAR(60)                     COMMENT 'Отчество',
        position            VARCHAR(255) NOT NULL           COMMENT 'Должность',
        phone               VARCHAR(11)  NOT NULL           COMMENT 'Номер телефона',
        is_identified       BOOLEAN                         COMMENT 'Идентификация',
        office_id           INTEGER                         COMMENT 'Внешний ключ на таблицу офисов',
        citizenship_id      INTEGER                         COMMENT 'Внешний ключ на таблицу гражданства',
        FOREIGN KEY (office_id) REFERENCES Office(id),
        FOREIGN KEY (citizenship_id) REFERENCES Citizenship(id)
);
CREATE INDEX IX_User_office_id ON User(office_id);
CREATE INDEX IX_User_citizenship_id ON User(citizenship_id);

COMMENT ON TABLE User IS 'Таблица пользователей';


CREATE TABLE IF NOT EXISTS Document_type (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT ,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    name                VARCHAR(255) NOT NULL           COMMENT 'Наименование',
    code                VARCHAR(255) NOT NULL           COMMENT 'Код'
);
CREATE INDEX IX_Document_type_code ON Document_type(code);

COMMENT ON TABLE Document_type IS 'Таблица типов документов';



CREATE TABLE IF NOT EXISTS Document (
    id                  INTEGER                         COMMENT 'Уникальный идентификатор' PRIMARY KEY,
    version             INTEGER      NOT NULL           COMMENT 'Служебное поле hibernate',
    document_type_id    INTEGER      NOT NULL           COMMENT 'Внешний ключ на таблицу типов документов',
    number              VARCHAR(25)  NOT NULL           COMMENT 'Номер',
    date                DATE         NOT NULL           COMMENT 'Дата',
    FOREIGN KEY (id) REFERENCES User(id),
    FOREIGN KEY (document_type_id) REFERENCES Document_type(id)
);
CREATE INDEX IX_Document_document_type_id ON Document(document_type_id);

COMMENT ON TABLE Document IS 'Таблица документов';














