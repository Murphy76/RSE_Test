INSERT INTO user(username,password,ENABLED) VALUES ('admin','$2a$10$MYDZKx1sCBfV.A3dN7oc9uWFPtw6VackhMmh9yAM/RiWtF21Q7ivi', true);
INSERT INTO user(username,password,ENABLED) VALUES ('user1','$2a$10$C.w6IzJJSN.N0qCLD1.Lq.RYsHQ6YX53JhJS2n5REM5g7p82roLby',true);
INSERT INTO role (user_id, role) VALUES ('admin', 'ROLE_USER');
INSERT INTO role (user_id, role) VALUES ('admin', 'ROLE_ADMIN');
INSERT INTO role (user_id, role) VALUES ('user1', 'ROLE_USER');
INSERT INTO NOTE (descr, note, user_id ) VALUES ('descr note 1', 'bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-','admin');
INSERT INTO NOTE (descr, note, user_id ) VALUES ('descr note 2', 'bla-bla-bla-bla-bla-b','admin');
INSERT INTO NOTE (descr, note, user_id ) VALUES ('descr note 1', 'bla-bla-bla-bla-bla-bla-bla-bla-bla-bla-','user1');
commit;

