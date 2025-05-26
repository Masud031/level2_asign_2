-- Active: 1747490419603@@127.0.0.1@5432@mynewdb1
CREATE Table "user"(
    ID SERIAL PRIMARY KEY,
    Username  VARCHAR(25)  NOT NULL
);

CREATE  TABLE  post(
ID  SERIAL  PRIMARY  KEY,
Tilte  TEXT  NOT NULL,
User_id INTEGER  REFERENCES "user"(id)  );

INSERT INTO "user"(Username) VALUES
( 'aks',1)
('batas',3)
('nodi',4);
