-- drop database fuhf2;

CREATE TABLE USERS (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       email VARCHAR(255) NOT NULL,
                       hashed_password VARCHAR(255),
                       salt VARCHAR(255),
                       status VARCHAR(50) NOT NULL,
                       role_id INT NOT NULL,
                       is_ban BIT(1)
);

CREATE TABLE `ADMIN` (
                         admin_id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT,
                         first_name VARCHAR(255) NOT NULL,
                         last_name VARCHAR(255) NOT NULL,
                         address VARCHAR(255) NOT NULL,
                         phone VARCHAR(20) NOT NULL,
                         FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE LANDLORD (
                          landlord_id INT AUTO_INCREMENT PRIMARY KEY,
                          user_id INT,
                          first_name VARCHAR(255) NOT NULL,
                          last_name VARCHAR(255) NOT NULL,
                          address VARCHAR(255) NOT NULL,
                          phone VARCHAR(20) NOT NULL,
                          FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE TENANT (
                        tenant_id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        first_name VARCHAR(255) NOT NULL,
                        last_name VARCHAR(255) NOT NULL,
                        address VARCHAR(255) NOT NULL,
                        phone VARCHAR(20) NOT NULL,
                        FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE AVATAR (
                        avatar_id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        avatar_url VARCHAR(255) NOT NULL,
                        FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE PROPERTY_LOCATION (
                                   location_id INT AUTO_INCREMENT PRIMARY KEY,
                                   location_name VARCHAR(255) NOT NULL,
                                   location_link LONGTEXT NOT NULL,
                                   distance_km FLOAT
);

CREATE TABLE HOUSE (
                       house_id INT AUTO_INCREMENT PRIMARY KEY,
                       house_name VARCHAR(255),
                       landlord_id INT,
                       address VARCHAR(255),
                       description_house LONGTEXT,
                       status VARCHAR(255),
                       location_id INT,
                       create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                       update_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id),
                       FOREIGN KEY (location_id) REFERENCES PROPERTY_LOCATION(location_id)
);

CREATE TABLE ROOM (
                      room_id INT AUTO_INCREMENT PRIMARY KEY,
                      house_id INT,
                      room_number INT,
                      status BIT(1),
                      price DECIMAL(10,2) NOT NULL,
                      area DECIMAL(10,2) NOT NULL,
                      create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                      update_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                      FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE utilities (
                           utilities_id INT AUTO_INCREMENT PRIMARY KEY,
                           utilities VARCHAR(255)
);

CREATE TABLE room_utilities (
                                room_id INT,
                                utilities_id INT,
                                FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
                                FOREIGN KEY (utilities_id) REFERENCES utilities(utilities_id)
);

CREATE TABLE HOUSE_IMAGE (
                             house_image_id INT AUTO_INCREMENT PRIMARY KEY,
                             house_id INT,
                             image_url VARCHAR(255) NOT NULL,
                             FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE ORDERS (
                        order_id INT AUTO_INCREMENT PRIMARY KEY,
                        tenant_id INT,
                        landlord_id INT,
                        status VARCHAR(50) NOT NULL,
                        room_id INT,
                        order_date DATE NOT NULL,
                        note VARCHAR(255),
                        isConfirm BIT(1) DEFAULT b'0',
                        FOREIGN KEY (tenant_id) REFERENCES TENANT(tenant_id),
                        FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id),
                        FOREIGN KEY (room_id) REFERENCES ROOM(room_id)
);

CREATE TABLE UPGRADE (
                         upgrade_id INT AUTO_INCREMENT PRIMARY KEY,
                         type VARCHAR(255) NOT NULL,
                         landlord_id INT,
                         transaction_id VARCHAR(255),
                         amount FLOAT,
                         description VARCHAR(255),
                         error_code VARCHAR(255),
                         ctt VARCHAR(255),
                         bank_code VARCHAR(255),
                         time_transaction DATETIME,
                         status BIT(1),
                         FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id)
);

CREATE TABLE REPORT (
                        report_id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        report_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                        report_problem VARCHAR(255) NOT NULL,
                        report_description LONGTEXT,
                        status BIT(1),
                        FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE REPLY_REPORT (
                              replyreport_id INT AUTO_INCREMENT PRIMARY KEY,
                              admin_id INT,
                              report_id INT,
                              reply_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                              reply_content LONGTEXT,
                              FOREIGN KEY (admin_id) REFERENCES `ADMIN`(admin_id),
                              FOREIGN KEY (report_id) REFERENCES REPORT(report_id)
);

CREATE TABLE FEEDBACK (
                          feedback_id INT AUTO_INCREMENT PRIMARY KEY,
                          tenant_id INT,
                          house_id INT,
                          feedback_date DATETIME NOT NULL,
                          rating_star INT NOT NULL CHECK (rating_star >= 1 AND rating_star <= 5),
                          feedback_content LONGTEXT,
                          FOREIGN KEY (tenant_id) REFERENCES TENANT(tenant_id),
                          FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE REPLY_FEEDBACK (
                                replyfeedback_id INT AUTO_INCREMENT PRIMARY KEY,
                                feedback_id INT,
                                landlord_id INT,
                                reply_date DATETIME NOT NULL,
                                reply_content LONGTEXT,
                                FOREIGN KEY (feedback_id) REFERENCES FEEDBACK(feedback_id),
                                FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id)
);

CREATE TABLE WISHLIST (
                          wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
                          tenant_id INT,
                          house_id INT,
                          FOREIGN KEY (tenant_id) REFERENCES TENANT(tenant_id),
                          FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE BLOG_POSTS (
                            post_id INT AUTO_INCREMENT PRIMARY KEY,
                            user_id INT NOT NULL,
                            title VARCHAR(255) NOT NULL,
                            content LONGTEXT NOT NULL,
                            publish_date DATETIME NOT NULL,
                            FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE HISTORY_ORDER (
                               history_id INT AUTO_INCREMENT PRIMARY KEY,
                               order_id INT,
                               history_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                               status VARCHAR(255),
                               FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
INSERT INTO USERS (EMAIL, HASHED_PASSWORD, SALT, STATUS, role_id, is_ban) VALUES
                                                                              ('hanhngulao66@gmail.com','eg7tCqX/yyJJyNGecVhoxxniicfogmi+YYR1jIHMiWw=','oKhjkpjAZGVCfh83lld5RA==','Đã xác minh',1,0),
                                                                              ('hoaithuong7203@gmail.com','P2sM+yFwcsyV+lP0GWeO+gH0uHtS+OMFSecEVpq/5rY=','PZIdCyWvsOVbxOabTtTfxg==','Đã xác minh',2,0),
                                                                              ('anh@gmail.com','0pOB/nXkNXs1bnithHgZbQkpL2a+fzoQbzSIjWdZ6Ag=','rvXaqeLDfSbtj1q4clohyw==','Chưa xác minh',3,0),
                                                                              ('danhuyn@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',3,1),
                                                                              ('huyennhe30@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,0),
                                                                              ('huyennhe29@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,0),
                                                                              ('huyennhe28@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,0),
                                                                              ('huyennhe27@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,0),
                                                                              ('huyennhe26@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,0),
                                                                              ('huyennhe25@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,0),
                                                                              ('huyennhe24@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,0),
                                                                              ('huyennhe23@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,0),
                                                                              ('huyennhe22@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,1),
                                                                              ('huyennhe21@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,1),
                                                                              ('huyennhe20@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,0),
                                                                              ('huyennhe19@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Chưa xác minh',2,1),
                                                                              ('huyennhe18@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',2,0),
                                                                              ('anhtt30@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',3,0),
                                                                              ('anhtt29@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',3,0),
                                                                              ('anhtt28@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',3,0),
                                                                              ('anhtt27@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==','Đã xác minh',3,0);

INSERT INTO `ADMIN` (USER_ID, FIRST_NAME, LAST_NAME, ADDRESS, PHONE)
VALUES (1,'Đỗ Đức','Hanh','Hải Phòng','0387006149');

INSERT INTO LANDLORD (USER_ID, FIRST_NAME, LAST_NAME, ADDRESS, PHONE)
VALUES
    (2,'Ngô Thị','Thương','Thạch Thất','0345456756'),
    (5,'Đặng Thị','Huyền','Đồng Trúc','0338392190'),
    (6,'Đặng','Huyền','Đồng Trúc','0338392191'),
    (7,'Trần Thị Thanh','Huyền','Đồng Trúc','0338392192'),
    (8,'Đinh Việt','Chung','Hạ Bằng','0338392193'),
    (9,'Hoàng Ngọc','Thủy','Cây xăng 39','0338392194'),
    (10,'Dang Thi','Huyen','Kim Bông','0338392195'),
    (11,'Nguyễn Mạnh','Hùng','Bình Yên','0338392196'),
    (12,'Đặng Hoàng','Thu','Đồng Trúc','0338392197'),
    (13,'Thu','Huyền','Tân Xã','0338392198'),
    (14,'Trần Thị','Hòa','Kim Bông','0338392199'),
    (15,'Trần Khánh','Đăng','Thạch Hòa','0338392200'),
    (16,'Ngọc','Huyền','Cổng phụ đại học FPT','0338392201'),
    (17,'Hoàng','Huyền','Chợ Hòa Lạc','0338392201');

INSERT INTO TENANT (USER_ID, FIRST_NAME, LAST_NAME, ADDRESS, PHONE)
VALUES
    (3,'Trương Tuấn','Anh','Thanh Hóa','0367845596'),
    (4,'Đặng Thị','Huyền','Thạch Thất','0312030045'),
    (18,'Trần Tuấn','Anh','Vĩnh Phúc','0367845595'),
    (19,'Hoàng Tuấn','Anh','Thanh Hóa','0367845594'),
    (20,'Trương Việt','Anh','Hà Nội','0367845593'),
    (21,'Đinh Đức','Anh','Nam Định','0367845592');

INSERT INTO AVATAR (USER_ID, AVATAR_URL) VALUES
                                             (1,'meoxam.jpg'),
                                             (2,'macdinh.jpg'),
                                             (3,'meoxam.jpg'),
                                             (4,'anh1.jpg'),
                                             (5,'anh2.jpeg'),
                                             (6,'anh3.jpg'),
                                             (7,'anh4.jpg'),
                                             (8,'anh5.jpg'),
                                             (9,'macdinh.jpg'),
                                             (10,'anh1.jpg'),
                                             (11,'macdinh.jpg'),
                                             (12,'anh4.jpg'),
                                             (13,'macdinh.jpg'),
                                             (14,'macdinh.jpg'),
                                             (15,'anh5.jpg'),
                                             (16,'macdinh.jpg'),
                                             (17,'macdinh.jpg'),
                                             (18,'anh3.jpg'),
                                             (19,'macdinh.jpg'),
                                             (20,'macdinh.jpg'),
                                             (21,'macdinh.jpg');

INSERT INTO PROPERTY_LOCATION (LOCATION_NAME, LOCATION_LINK, distance_km)
VALUES
    ('Cổng phụ đại học FPT','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1862.237978463236!2d105.52060600414504!3d21.013633546504323!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1721130077289!5m2!1svi!2s', 1.0),
    ('Bình Yên','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29790.539772201293!2d105.51907987568343!3d21.039988209150216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134597c4ea419e3%3A0x2f7dd97ffc4ca74e!2zQsOsbmggWcOqbiwgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1721130104648!5m2!1svi!2s', 4.0),
    ('Đồng Trúc','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29799.91715727385!2d105.54838787560122!3d20.993052211403366!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a5e76ba243f%3A0xc06ad47e22c9c260!2zxJDhu5NuZyBUcsO6YywgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1721130137914!5m2!1svi!2s', 8.0),
    ('Hạ Bằng','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7449.559241615418!2d105.5511474425076!3d21.00146932256389!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a4fcb5b7bdd%3A0xaaccdaacb095f8d9!2zSOG6oSBC4bqxbmcsIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130175519!5m2!1svi!2s', 3.5),
    ('Kim Quan','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14895.12397537505!2d105.56558675264775!3d21.041447239773962!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313459f3cfb1b39f%3A0xcce2cb9865b0388b!2zS2ltIFF1YW4sIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130226612!5m2!1svi!2s', 5.0),
    ('Tân Xã','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7448.304791677911!2d105.54775700732445!3d21.02658742262832!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a2f0ba12d3b%3A0xe374f59afa28a30!2zVMOibiBYw6MsIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130270182!5m2!1svi!2s', 2.5),
    ('Chợ Hòa Lạc','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.1321671808137!2d105.51390598104956!3d21.027397030655653!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab68896793c9%3A0x9fcb0b4cae00323!2zQ2jhu6MgSMOyYSBM4bqhYw!5e0!3m2!1svi!2s!4v1721130297557!5m2!1svi!2s', 3.5),
    ('Cây Xăng 39','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5266839790756!2d105.51587167530064!3d21.011601980633472!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b9470b1cc8f%3A0x5dd90f9a7e60c3f4!2zVHLhuqFtIFjEg25nIEThuqd1IFRo4bqhY2ggSMOyYSAzOQ!5e0!3m2!1svi!2s!4v1721130330984!5m2!1svi!2s', 3.2),
    ('Thôn 3 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5703005895402!2d105.5154376753005!3d21.00985503063476!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b9408ea8a5f%3A0x189e38352978a939!2zVGjDtG4gMyBUaOG6oWNoIEjDsmEgSMOyYSBM4bqhYw!5e0!3m2!1svi!2s!4v1721130381778!5m2!1svi!2s', 3.5),
    ('Thôn 4 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.262970642735!2d105.51878687530086!3d21.022161380625445!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345bc735611631%3A0xa1693973fe734b8!2zTmjDoCBWxINuIEhvw6EgVGjDtG4gNCBUaOG6oWNoIEhvw6A!5e0!3m2!1svi!2s!4v1721130405672!5m2!1svi!2s', 4.0),
    ('Phenikaa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.2078591263094!2d105.53214538104169!3d20.984303430771376!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b05e7215ab7%3A0xad2d33af7819eb7a!2sPhenikaa!5e0!3m2!1svi!2s!4v1721130449322!5m2!1svi!2s', 3.8),
    ('Thôn 2 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29800.868232291523!2d105.48763227717818!3d20.988286261973812!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b74d5000dd9%3A0x78f00cc4a35484b9!2zSMOyYSBM4bqhYywgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2sus!4v1721135528710!5m2!1svi!2sus', 3.2);

INSERT INTO HOUSE (LANDLORD_ID, HOUSE_NAME, ADDRESS, DESCRIPTION_HOUSE, STATUS, LOCATION_ID)
VALUES
    (1,
     'V Village',
     'Ngõ 135 Đường Kim Bông',
     ' Chào mừng bạn đến với V Village - Nơi Tinh Hoa Cuộc Sống Hòa Quyện!
      Bạn đang tìm kiếm một nơi ở lý tưởng tại Hòa Lạc? Với V Village, không chỉ là một căn phòng trọ, mà còn là điểm dừng chân an lành, nơi mà bạn có thể tận hưởng cuộc sống đẳng cấp và tiện nghi.
      Với môi trường xanh mát và yên bình, V Village mang lại không gian sống gần gũi với thiên nhiên, giúp bạn thoải mái tận hưởng những khoảnh khắc bình yên giữa cuộc sống hối hả.
      Vị trí đắc địa tại trung tâm Hòa Lạc, V Village kết nối dễ dàng với các trường đại học, khu vực mua sắm và các tiện ích công cộng khác, mang lại sự thuận tiện cho cuộc sống hàng ngày.
      Với các căn phòng trọ được trang bị đầy đủ tiện nghi và nội thất hiện đại, bạn sẽ tìm thấy sự thoải mái và tiện lợi ở V Village.
      Hãy đặt chân đến V Village ngay hôm nay để khám phá không gian sống đẳng cấp và
      trải nghiệm cuộc sống an lành tại Hòa Lạc!',
     'Còn phòng',
     5),

    (2,
     'Chung cư Mini - Hòa Lạc Apartment',
     '206 Cụm 1',
     'THUÊ PHÒNG TRỌ SINH VIÊN Bạn sẽ nhận lại những gì ...?
     Đến với Chung cư Mini - Hòa Lạc Apartment, bạn sẽ nhận được :
     1- Mức giá ưu đãi đặc biệt, nếu 2 - 3 bạn cùng ở thì chi phí sẽ rất hợp lý.
     2- Vị trí nằm giữa trung tâm khu đô thị vệ tinh Hoà Lạc
     3- Phòng có sự decor tỉ mỉ, đảm bảo công năng thuận tiện học tập, phòng siêu thoáng mát, view đồi núi mây xanh ngút tầm mắt ... Khuôn viên xanh mát mẻ hòa mình với môi trường.
     4- Hệ thống phòng ở đầy đủ nội thất tiện nghi, hiện đại đón đầu xu hướng với bếp, giường ngủ, điều hòa, máy giặt, tủ lạnh, ban công Loza... đặc biệt: TẤT CẢ ĐỀU MỚI TINH TINH, bạn sẽ là người đầu tiên sử dụng
     - Phù hợp với các bạn sinh viên ở từ 2 - 3 người
     - Lựa chọn hàng đầu, giúp các bạn tìm đươc nơi ở với chi phí vô cùng hợp lý mà lại nâng tầm cuộc sống
     - Phòng đẹp lịm tim - Xem là thích liền',
     'Còn phòng',
     12),

    (3,
     'Young House',
     'Sau Nhà Văn Hóa thôn Thái Bình',
     'Chào các bạn!! Young House tự hào giới thiệu tòa nhà mới nhất - Young House 9 tọa lạc tại Hòa Lạc!
      Với mức giá siêu sinh viên chỉ từ 1,6 triệu đồng, Young House 9 mang đến cho bạn cơ hội trải nghiệm không gian sống hiện đại và tiện nghi.
     Tại Young House 9, bạn sẽ được trải nghiệm:
     - Phòng rộng rãi, thoải mái, được trang bị đầy đủ nội thất cao cấp như điều hòa, bình nóng lạnh, giường, tủ, bàn học,...
     - Khung cảnh thiên nhiên xanh mướt, yên bình và lãng mạn, tạo nên một không gian sống lý tưởng.
     - Nhiều ưu đãi hấp dẫn như chuyển đồ miễn phí, tặng nước uống và có cơ hội việc làm tại Young Group.
     - Đến với Young House 9, bạn sẽ được trải nghiệm dịch vụ phòng ở mãi đỉnh tại Bình Yên.',
     'Còn phòng',
     2),
    (4,
     'New House',
     'Lô 18, TĐC Bắc Phú Cát',
     'New House Hòa Lạc cho thuê phòng trọ giá rẻ, chỉ từ 1tr6/phòng.
     Căn hộ mới xây dựng, được trang bị Phòng Cháy Chữa Cháy đầy đủ, đảm bảo an toàn.
     Mở cửa là thấy: Siêu Thị, Mixue Thạch Hòa, Tạp Hóa, Hiệu Thuốc, Cửa hàng điện thoại, TocoToco,
     Chợ Cóc ngay bên cạnh thuận tiện cho việc mua đồ ăn nấu nướng tại phòng, cách Sân bóng nhân tạo 200m,...',
     'Còn phòng',
     9),

    (5,
     'Trọ Thảo Nguyên',
     'Ngõ 28 đường Tân Xã',
     'Nhà trọ Thảo Nguyên tọa lạc tại ngõ 28 đường Tân Xã,
     mang đến cho bạn một không gian sống yên tĩnh và thoáng mát. Mỗi phòng đều rộng rãi, với cửa sổ lớn đón ánh sáng tự nhiên,
     tạo cảm giác thoải mái và dễ chịu. Nội thất trong phòng được trang bị đầy đủ gồm giường, tủ quần áo, bàn học, điều hòa và máy giặt.
     Nhà vệ sinh riêng biệt có bình nóng lạnh, đảm bảo sự tiện nghi tối đa cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ có nhiều cây xanh,
     tạo nên một môi trường sống trong lành. Ngoài ra, nhà trọ gần các tiện ích như cửa hàng tiện lợi, siêu thị, và nhà hàng,
     giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.',
     'Còn phòng',
     6),

    (6,
     'Trọ Bình An',
     'Khu đô thị Bình Yên',
     'Nhà trọ Bình An nằm trong khu đô thị Bình Yên,
     mang đến một không gian sống tiện nghi và thoải mái. Các phòng trọ được thiết kế hiện đại với ban công riêng,
     giúp bạn có thể thư giãn sau những giờ làm việc căng thẳng. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo,
     bàn làm việc, điều hòa, và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh khép kín có máy nước nóng,
     mang lại sự tiện nghi tối đa. Nhà trọ gần các cửa hàng tiện lợi, khu vực ăn uống và trạm xe buýt, rất thuận tiện cho việc di chuyển.
     Hệ thống an ninh với bảo vệ 24/7 đảm bảo an toàn tuyệt đối cho bạn.',
     'Còn phòng',
     2),

    (7,
     'Trọ Cổng Phụ',
     'Cổng phụ đại học FPT',
     'Nhà trọ Cổng Phụ nằm ngay cạnh cổng phụ đại học FPT,
     là lựa chọn lý tưởng cho sinh viên. Phòng trọ mới xây dựng, sạch sẽ và thoáng mát,
     được trang bị đầy đủ nội thất hiện đại bao gồm giường, tủ quần áo, bàn học, điều hòa và máy giặt.
     Mỗi phòng đều có nhà vệ sinh riêng với máy nước nóng, đảm bảo sự tiện nghi cho sinh hoạt hàng ngày.
     Khu vực xung quanh có an ninh tốt, nhiều quán cà phê, cửa hàng tiện lợi và các dịch vụ ăn uống,
     tạo điều kiện thuận lợi cho cuộc sống sinh viên.',
     'Còn phòng',
     1),

    (8,
     'Trọ Thanh Thúy',
     'Ngõ 15 đường Đồng Trúc',
     'Nhà trọ Thanh Thúy cung cấp một không gian sống tiện nghi với mức giá hợp lý.
     Các phòng rộng rãi, thoáng mát, được trang bị đầy đủ nội thất mới bao gồm giường ngủ, tủ quần áo, bàn làm việc,
     điều hòa và máy giặt. Nhà vệ sinh riêng biệt có máy nước nóng, giúp bạn luôn cảm thấy thoải mái. Khu vực xung quanh nhà trọ yên tĩnh,
     gần khu công nghiệp và các tiện ích công cộng như siêu thị, cửa hàng tiện lợi và nhà hàng. An ninh được đảm bảo 24/7 với
     hệ thống bảo vệ hiện đại.',
     'Còn phòng',
     3),
    (9,
     'Trọ Kim Quan',
     'Ngõ 2 đường Kim Quan',
     'Nhà trọ Kim Quan nằm tại ngõ 2 đường Kim Quan,
     mang đến cho bạn một không gian sống xanh mát và yên tĩnh. Phòng trọ được thiết kế với không gian mở,
     có cửa sổ lớn, giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ,
     tủ quần áo, bàn làm việc, điều hòa và máy giặt, tất cả đều được trang bị đầy đủ và mới. Nhà vệ sinh riêng
     với máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ gần các trường đại học, khu vực
     mua sắm và các tiện ích công cộng khác, mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.',
     'Còn phòng',
     5),

    (10,
     'Trọ Tân Xã',
     'Số 10 đường Tân Xã',
     'Nhà trọ Tân Xã tọa lạc tại số 10 đường Tân Xã, mang đến cho bạn
     một không gian sống hiện đại và tiện nghi. Các phòng rộng rãi, thoáng mát, có view đẹp, giúp bạn luôn cảm thấy
     thư thái và thoải mái. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa, máy giặt và
     máy nước nóng, tất cả đều mới và chất lượng cao. Khu vực xung quanh nhà trọ an ninh tốt, nhiều cửa hàng tiện lợi,
     siêu thị và nhà hàng, giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.',
     'Còn phòng',
     6),

    (11,
     'Trọ Chợ Hòa Lạc',
     'Ngõ 7 đường Chợ Hòa Lạc',
     'Nhà trọ Chợ Hòa Lạc nằm tại ngõ 7 đường Chợ Hòa Lạc,
     mang đến cho bạn một không gian sống tiện nghi và thoải mái. Phòng trọ được thiết kế với không gian mở, có cửa sổ lớn,
     giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc,
     điều hòa và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi
     cho sinh hoạt hàng ngày. Nhà trọ gần chợ và các tiện ích công cộng như siêu thị, cửa hàng tiện lợi và nhà hàng,
     mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.',
     'Còn phòng',
     7),

    (12,
     'Trọ Cây Xăng 39',
     'Gần cây xăng 39',
     'Nhà trọ Cây Xăng 39 tọa lạc gần cây xăng 39, mang đến cho bạn một
     không gian sống tiện nghi và thoải mái. Các phòng rộng rãi, thoáng mát, được thiết kế với không gian mở, có cửa sổ lớn,
     giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa
     và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày.
     Nhà trọ gần cây xăng và các cửa hàng tiện lợi, giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.',
     'Còn phòng',
     8),

    (13,
     'Trọ Thôn 3 Thạch Hòa',
     'Ngõ 4 đường Thôn 3 Thạch Hòa',
     'Nhà trọ Thôn 3 Thạch Hòa nằm tại ngõ 4 đường Thôn
     3 Thạch Hòa, mang đến cho bạn một không gian sống yên tĩnh và gần gũi với thiên nhiên. Phòng trọ được thiết kế với không gian mở,
     có cửa sổ lớn, giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc,
     điều hòa và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày.
     Khu vực xung quanh nhà trọ có nhiều cây xanh, tạo nên một môi trường sống trong lành, gần các tiện ích công cộng như siêu thị,
     cửa hàng tiện lợi và nhà hàng.',
     'Còn phòng',
     9),

    (14,
     'Trọ Thôn 4 Thạch Hòa',
     'Số 5 đường Thôn 4 Thạch Hòa',
     'Nhà trọ Thôn 4 Thạch Hòa tọa lạc tại số 5 đường Thôn 4 Thạch Hòa,
     mang đến cho bạn một không gian sống tiện nghi và thoải mái. Các phòng rộng rãi, thoáng mát, có cửa sổ lớn, giúp bạn luôn cảm thấy
     thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa và máy giặt, tất cả đều mới và
     chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ an ninh tốt,
     gần các trường đại học, khu vực mua sắm và các tiện ích công cộng khác,
     mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.',
     'Còn phòng',
     10);
INSERT INTO ROOM (HOUSE_ID, ROOM_NUMBER, STATUS, PRICE, AREA) VALUES
                                                                  (1, 101, 1, 3000000, 35),
                                                                  (2, 501, 1, 3500000, 35),
                                                                  (3, 303, 1, 3000000, 30),
                                                                  (4, 404, 1, 2600000, 30),
                                                                  (4, 201, 1, 2300000, 25),
                                                                  (5, 101, 1, 1300000, 20),
                                                                  (5, 102, 1, 1500000, 22),
                                                                  (5, 201, 1, 1700000, 25),
                                                                  (6, 101, 1, 1200000, 18),
                                                                  (6, 102, 1, 1400000, 20),
                                                                  (7, 301, 1, 1500000, 20),
                                                                  (8, 102, 1, 1200000, 20),
                                                                  (9, 102, 1, 1800000, 25),
                                                                  (10, 102, 1, 4500000, 32),
                                                                  (11, 103, 1, 1200000, 20),
                                                                  (12, 102, 1, 1800000, 25),
                                                                  (13, 201, 1, 1600000, 20),
                                                                  (14, 102, 1, 1200000, 17),
                                                                  (1, 102, 1, 1700000, 20),
                                                                  (1, 103, 1, 2000000, 23),
                                                                  (2, 101, 1, 3000000, 25),
                                                                  (2, 102, 1, 3100000, 26);
INSERT INTO utilities (utilities) VALUES
                                      ('Điều hòa'),
                                      ('Wifi'),
                                      ('Nóng lạnh'),
                                      ('Bàn Học'),
                                      ('Giường'),
                                      ('Tủ quần áo'),
                                      ('Bàn bếp'),
                                      ('Quạt'),
                                      ('Tủ lạnh'),
                                      ('Hệ thống hút mùi'),
                                      ('Bồn rửa');
INSERT INTO room_utilities (room_id, utilities_id) VALUES
                                                       (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,10),
                                                       (2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,10),
                                                       (3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,10),
                                                       (4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,10),
                                                       (5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,10),
                                                       (6,1),(6,2),(6,3),(6,4),(6,5),
                                                       (7,1),(7,2),(7,3),(7,4),(7,5),(7,8),(7,11),
                                                       (8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,8),(8,11),
                                                       (9,1),(9,2),(9,3),(9,8),
                                                       (10,1),(10,2),(10,3),(10,5),(10,8),
                                                       (11,1),(11,2),(11,3),(11,4),(11,5),(11,8),
                                                       (12,1),(12,2),(12,3),(12,4),(12,5),(12,8),
                                                       (13,1),(13,2),(13,3),(13,4),(13,5),(13,8),
                                                       (14,1),(14,2),(14,3),(14,4),(14,5),(14,6),(14,7),
                                                       (14,8),(14,9),(14,10),(14,11),
                                                       (15,1),(15,2),(15,3),(15,5),
                                                       (16,1),(16,2),(16,3),(16,4),(16,5),(16,8),(16,11),
                                                       (17,1),(17,2),(17,3),(17,5),(17,8),
                                                       (18,1),(18,2),(18,3),(18,5),(18,8),
                                                       (19,1),(19,2),(19,3),(19,4),(19,5),
                                                       (20,1),(20,2),(20,3),(20,6),(20,5),(20,8),
                                                       (21,1),(21,2),(21,3),(21,4),(21,5),(21,6),(21,8),
                                                       (22,1),(22,2),(22,3),(22,4),(22,5),(22,6),(22,8),(22,11);

INSERT INTO HOUSE_IMAGE (HOUSE_ID, IMAGE_URL)
VALUES
    (1,'house1.1.jpg'),(1,'house1.2.jpg'),(1,'house1.3.jpg'),(1,'house1.4.jpg'),(1,'house1.5.jpg'),
    (1,'house1.6.jpg'),(1,'house1.7.jpg'),(1,'house1.8.jpg'),(1,'house1.9.jpg'),(1,'house1.10.jpg'),
    (2,'house2.1.jpg'),(2,'house2.2.jpg'),(2,'house2.3.jpg'),(2,'house2.4.jpg'),(2,'house2.5.jpg'),
    (2,'house2.6.jpg'),(3,'house3.1.jpg'),(3,'house3.2.jpg'),(3,'house3.3.jpg'),(4,'house4.1.jpg'),
    (4,'house4.2.jpg'),(4,'house4.3.jpg'),(4,'house4.4.jpg'),(4,'house4.5.jpg'),(5,'house5.1.jpg'),
    (5,'house5.2.jpg'),(6,'house6.1.jpg'),(6,'house6.2.jpg'),(6,'house6.3.jpg'),(7,'house7.1.jpg'),
    (7,'house7.2.jpg'),(8,'house8.1.jpg'),(8,'house8.2.jpg'),(9,'house9.1.jpg'),(9,'house9.2.jpg'),
    (10,'house10.1.jpg'),(10,'house10.2.jpg'),(11,'house11.1.jpg'),(11,'house4.2.jpg'),(12,'house12.1.jpg'),
    (12,'house12.2.jpg'),(13,'house13.1.jpg'),(13,'house13.2.jpg'),(14,'house14.1.jpg'),(14,'house14.2.jpg'),
    (1,'house1_room101.2.jpg'),(1,'house1_room101.3.jpg'),(1,'house1_room101.4.jpg'),(1,'house1_room101.5.jpg'),
    (2,'house2_room501.1.jpg'),(2,'house2_room501.2.jpg'),(2,'house2_room501.3.jpg'),(2,'house2_room501.4.jpg');
-- INSERT INTO HISTORY_ORDER(order_id, `status`)
-- VALUES
--     (1, 'Pending'),
--     (1, 'Approve');


INSERT INTO UPGRADE (type, landlord_id, transaction_id, amount, description, error_code, ctt, bank_code, time_transaction, status)
VALUES
    ('Tiêu chuẩn', 2, '20205357', 899000, 'Thanh toan don hang:20205357', 0, '14502837', 'NCB', '2024-07-09 20:59:50', 1),
    ('Nâng Cao', 3, '89983365', 1499000, 'Thanh toan don hang:89983365', 0, '14502838', 'NCB', '2024-07-09 21:02:09', 1);


INSERT INTO REPORT (USER_ID, REPORT_PROBLEM, REPORT_DESCRIPTION, status)
VALUES
    (3, 'Có lỗi phần mềm', 'Phần mềm này có lỗi nghiêm trọng', 1),
    (3, 'Thông tin về trọ không đúng', 'Thông tin được đăng không chính xác với thực tế', 0);


INSERT INTO REPLY_REPORT (admin_id, report_id, reply_content)
VALUES
    (1, 1, 'Cảm ơn bạn đã gửi báo cáo về lỗi này');


INSERT INTO FEEDBACK (tenant_id, house_id, feedback_date, rating_star, feedback_content)
VALUES
    (1, 1, '2024-05-28 12:30:45', 4, 'Phòng rộng rãi sạch sẽ'),
    (2, 2, '2024-05-28 12:30:45', 5, 'Phòng đẹp lắm');


INSERT INTO REPLY_FEEDBACK (feedback_id, landlord_id, reply_date, reply_content)
VALUES
    (1, 1, '2024-05-28 12:30:45', 'Cảm ơn đánh giá của bạn'),
    (2, 2, '2024-05-28 12:30:45', 'Cảm ơn bạn đã đánh giá');


INSERT INTO WISHLIST (TENANT_ID, house_id)
VALUES (1, 1);