CREATE DATABASE FUHF2

USE FUHF2

CREATE TABLE USERS (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    email VARCHAR(255) NOT NULL,
    hashed_password VARCHAR(255) ,
	salt VARCHAR(255) ,
    status NVARCHAR(50) NOT NULL,
	role_id int NOT NULL,
	is_ban BIT,
);

CREATE TABLE [ADMIN] (
    admin_id INT PRIMARY KEY IDENTITY(1,1),
	user_id INT,
    first_name NVARCHAR(255) NOT NULL,
    last_name NVARCHAR(255) NOT NULL,
	address NVARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE LANDLORD (
    landlord_id INT PRIMARY KEY IDENTITY(1,1) ,
	user_id INT,
    first_name NVARCHAR(255) NOT NULL,
    last_name NVARCHAR(255) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE TENANT (
    tenant_id INT PRIMARY KEY IDENTITY(1,1),
	user_id INT,
    first_name NVARCHAR(255) NOT NULL,
    last_name NVARCHAR(255) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE AVATAR (
	avatar_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT ,
    avatar_url VARCHAR(255) NOT NULL
	FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE PROPERTY_LOCATION (
    location_id INT PRIMARY KEY IDENTITY(1,1),
    location_name NVARCHAR(255) NOT NULL,
	location_link NVARCHAR(MAX) NOT NULL,
distance_km FLOAT

);

CREATE TABLE HOUSE(
	house_id INT PRIMARY KEY IDENTITY(1,1),
	house_name NVARCHAR(255),
	landlord_id INT,
	address NVARCHAR(255),
	description_house NVARCHAR(MAX),
	status NVARCHAR(255),
	location_id INT,
		create_date DATETIME DEFAULT GETDATE(),
    update_date DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id),
	FOREIGN KEY (location_id) REFERENCES PROPERTY_LOCATION(location_id)
);

CREATE TABLE ROOM(
	room_id INT PRIMARY KEY IDENTITY(1,1),
	house_id INT,
	room_number INT,
	status bit,  
	price DECIMAL(10, 2) NOT NULL,
	area  DECIMAL(10, 2) NOT NULL,   
	create_date DATETIME DEFAULT GETDATE(),
    update_date DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE utilities (
	utilities_id INT PRIMARY KEY IDENTITY(1,1),
	utilities NVARCHAR(255),
)

CREATE TABLE room_utilities(
	room_id INT,
	utilities_id INT,
	FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
	FOREIGN KEY (utilities_id) REFERENCES utilities(utilities_id)
)

CREATE TABLE HOUSE_IMAGE (
    house_image_id INT PRIMARY KEY IDENTITY(1,1),
    house_id INT,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    tenant_id INT,
    landlord_id INT,
    status NVARCHAR(50) NOT NULL,
	room_id int,
    order_date DATE NOT NULL,
	note NVARCHAR(255),
	isConfirm bit default 0,
    FOREIGN KEY (TENANT_ID) REFERENCES TENANT(TENANT_ID),
    FOREIGN KEY (LANDLORD_ID) REFERENCES LANDLORD(LANDLORD_ID),
	FOREIGN KEY (room_id) REFERENCES ROOM(room_id)
);

CREATE TABLE UPGRADE (
    upgrade_id INT PRIMARY KEY IDENTITY(1,1),
    type NVARCHAR(255) NOT NULL,
	landlord_id INT,
	transaction_id VARCHAR(255),
	amount FLOAT,
	description NVARCHAR(255),
	error_code VARCHAR(255),
	ctt VARCHAR(255),
	bank_code VARCHAR(255),
	time_transaction DATETIME,
	status BIT,   -- 1 la thanh cong, 0 la that bai
	FOREIGN KEY (landlord_id) REFERENCES LANDLORD(landlord_id)
);

CREATE TABLE REPORT (
    report_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    report_date DATETIME DEFAULT GETDATE(),
    report_problem NVARCHAR(255) NOT NULL,
    report_description NVARCHAR(MAX),
	status bit,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE REPLY_REPORT (
    replyreport_id INT PRIMARY KEY IDENTITY(1,1),
    admin_id INT,
	report_id INT,
    reply_date DATETIME DEFAULT GETDATE(),
    reply_content NVARCHAR(MAX),
    FOREIGN KEY (admin_id) REFERENCES [admin](admin_id),
	FOREIGN KEY (report_id) REFERENCES report(report_id)
);

CREATE TABLE FEEDBACK (
    feedback_id INT PRIMARY KEY IDENTITY(1,1),
    tenant_id INT, 
	house_id INT,
    feedback_date DATE NOT NULL,
    rating_star INT NOT NULL CHECK (RATING_STAR >= 1 AND RATING_STAR <= 5),
    feedback_content NVARCHAR(MAX),
    FOREIGN KEY (TENANT_ID) REFERENCES TENANT(TENANT_ID),
	FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE REPLY_FEEDBACK (
    replyfeedback_id INT PRIMARY KEY IDENTITY(1,1),
    feedback_id INT,
	landlord_id INT,
    reply_date DATE NOT NULL,
    reply_content NVARCHAR(MAX),
    FOREIGN KEY (feedback_id) REFERENCES feedback(feedback_id),
	FOREIGN KEY (landlord_id) REFERENCES landlord(landlord_id)
);

CREATE TABLE WISHLIST (
    wishlist_id INT PRIMARY KEY IDENTITY(1,1),
    tenant_id INT,
	house_id INT,
    FOREIGN KEY (TENANT_ID) REFERENCES TENANT(TENANT_ID),
	FOREIGN KEY (house_id) REFERENCES HOUSE(house_id)
);

CREATE TABLE BLOG_POSTS (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    publish_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE HISTORY_ORDER(
	history_id int primary key identity(1,1),
	order_id int,
	history_date Datetime default getDate(),
	status nvarchar(255),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

------------------------------------------------
---------------------------------------------------------------------

INSERT INTO USERS (EMAIL , HASHED_PASSWORD,SALT ,STATUS, role_id, is_ban) VALUES
('hanhngulao66@gmail.com','eg7tCqX/yyJJyNGecVhoxxniicfogmi+YYR1jIHMiWw=','oKhjkpjAZGVCfh83lld5RA==',N'Đã xác minh',1,0),
('hoaithuong7203@gmail.com','P2sM+yFwcsyV+lP0GWeO+gH0uHtS+OMFSecEVpq/5rY=','PZIdCyWvsOVbxOabTtTfxg==',N'Đã xác minh',2,0),
('anh@gmail.com','0pOB/nXkNXs1bnithHgZbQkpL2a+fzoQbzSIjWdZ6Ag=','rvXaqeLDfSbtj1q4clohyw==',N'Chưa xác minh',3,0),
('danhuyn@gmail.com','3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=','qXEx01LKTOKOzWqfkj7W3g==',N'Đã xác minh',3,1),
('huyennhe30@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,0),
('huyennhe29@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,0),
('huyennhe28@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,0),
('huyennhe27@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,0),
('huyennhe26@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,0),
('huyennhe25@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,0),
('huyennhe24@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,0),
('huyennhe23@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,0),
('huyennhe22@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,1),
('huyennhe21@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,1),
('huyennhe20@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,0),
('huyennhe19@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Chưa xác minh', 2,1),
('huyennhe18@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 2,0),
('anhtt30@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 3,0),
('anhtt29@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 3,0),
('anhtt28@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 3,0),
('anhtt27@gmail.com', '3QgcB1DAgrZOqDoa4AbOtb3QrTWA6MllSona0a5gT0M=', 'qXEx01LKTOKOzWqfkj7W3g==', N'Đã xác minh', 3,0);

INSERT INTO [ADMIN] (USER_ID, FIRST_NAME , LAST_NAME, ADDRESS, PHONE ) VALUES (1,N'Đỗ Đức',N'Hanh',N'Hải Phòng','0387006149');

INSERT INTO LANDLORD (USER_ID, FIRST_NAME, LAST_NAME, ADDRESS, PHONE) 
VALUES 
(2, N'Ngô Thị', N'Thương', N'Thạch Thất', '0345456756'),
(5, N'Đặng Thị', N'Huyền', N'Đồng Trúc', '0338392190'),
(6, N'Đặng', N'Huyền', N'Đồng Trúc', '0338392191'),
(7, N'Trần Thị Thanh', N'Huyền', N'Đồng Trúc', '0338392192'),
(8, N'Đinh Việt', N'Chung', N'Hạ Bằng', '0338392193'),
(9, N'Hoàng Ngọc', N'Thủy', N'Cây xăng 39', '0338392194'),
(10, N'Dang Thi', N'Huyen', N'Kim Bông', '0338392195'),
(11, N'Nguyễn Mạnh', N'Hùng', N'Bình Yên', '0338392196'),
(12, N'Đặng Hoàng', N'Thu', N'Đồng Trúc', '0338392197'),
(13, N'Thu', N'Huyền', N'Tân Xã', '0338392198'),
(14, N'Trần Thị', N'Hòa', N'Kim Bông', '0338392199'),
(15, N'Trần Khánh', N'Đăng', N'Thạch Hòa', '0338392200'),
(16, N'Ngọc', N'Huyền', N'Cổng phụ đại học FPT', '0338392201'),
(17, N'Hoàng', N'Huyền', N'Chợ Hòa Lạc', '0338392201');

INSERT INTO TENANT (USER_ID, FIRST_NAME , LAST_NAME, ADDRESS, PHONE ) VALUES 
(3,N'Trương Tuấn',N'Anh',N'Thanh Hóa','0367845596'),
(4,N'Đặng Thị',N'Huyền',N'Thạch Thất','0312030045'),
(18,N'Trần Tuấn',N'Anh',N'Vĩnh Phúc','0367845595'),
(19,N'Hoàng Tuấn',N'Anh',N'Thanh Hóa','0367845594'),
(20,N'Trương Việt',N'Anh',N'Hà Nội','0367845593'),
(21,N'Đinh Đức',N'Anh',N'Nam Định','0367845592');

INSERT INTO AVATAR (USER_ID,AVATAR_URL) VALUES 
(1, 'meoxam.jpg'),
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

INSERT INTO PROPERTY_LOCATION (LOCATION_NAME, LOCATION_LINK,distance_km) VALUES 
(N'Cổng phụ đại học FPT','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1862.237978463236!2d105.52060600414504!3d21.013633546504323!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1721130077289!5m2!1svi!2s', 1.0),
(N'Bình Yên','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29790.539772201293!2d105.51907987568343!3d21.039988209150216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134597c4ea419e3%3A0x2f7dd97ffc4ca74e!2zQsOsbmggWcOqbiwgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1721130104648!5m2!1svi!2s', 4.0),
(N'Đồng Trúc','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29799.91715727385!2d105.54838787560122!3d20.993052211403366!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a5e76ba243f%3A0xc06ad47e22c9c260!2zxJDhu5NuZyBUcsO6YywgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1721130137914!5m2!1svi!2s', 8.0),
(N'Hạ Bằng','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7449.559241615418!2d105.5511474425076!3d21.00146932256389!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a4fcb5b7bdd%3A0xaaccdaacb095f8d9!2zSOG6oSBC4bqxbmcsIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130175519!5m2!1svi!2s', 3.5),
(N'Kim Quan','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14895.12397537505!2d105.56558675264775!3d21.041447239773962!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313459f3cfb1b39f%3A0xcce2cb9865b0388b!2zS2ltIFF1YW4sIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130226612!5m2!1svi!2s', 5.0),
(N'Tân Xã','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7448.304791677911!2d105.54775700732445!3d21.02658742262832!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345a2f0ba12d3b%3A0xe374f59afa28a30!2zVMOibiBYw6MsIFRo4bqhY2ggVGjhuqV0LCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1721130270182!5m2!1svi!2s', 2.5),
(N'Chợ Hòa Lạc','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.1321671808137!2d105.51390598104956!3d21.027397030655653!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab68896793c9%3A0x9fcb0b4cae00323!2zQ2jhu6MgSMOyYSBM4bqhYw!5e0!3m2!1svi!2s!4v1721130297557!5m2!1svi!2s', 3.5),
(N'Cây Xăng 39','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5266839790756!2d105.51587167530064!3d21.011601980633472!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b9470b1cc8f%3A0x5dd90f9a7e60c3f4!2zVHLhuqFtIFjEg25nIEThuqd1IFRo4bqhY2ggSMOyYSAzOQ!5e0!3m2!1svi!2s!4v1721130330984!5m2!1svi!2s', 3.2),
(N'Thôn 3 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5703005895402!2d105.5154376753005!3d21.00985503063476!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b9408ea8a5f%3A0x189e38352978a939!2zVGjDtG4gMyBUaOG6oWNoIEjDsmEgSMOyYSBM4bqhYw!5e0!3m2!1svi!2s!4v1721130381778!5m2!1svi!2s', 3.5),
(N'Thôn 4 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.262970642735!2d105.51878687530086!3d21.022161380625445!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345bc735611631%3A0xa1693973fe734b8!2zTmjDoCBWxINuIEhvw6EgVGjDtG4gNCBUaOG6oWNoIEhvw6A!5e0!3m2!1svi!2s!4v1721130405672!5m2!1svi!2s', 4.0),
(N'Phenikaa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.2078591263094!2d105.53214538104169!3d20.984303430771376!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b05e7215ab7%3A0xad2d33af7819eb7a!2sPhenikaa!5e0!3m2!1svi!2s!4v1721130449322!5m2!1svi!2s', 3.8),
(N'Thôn 2 Thạch Hòa','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29800.868232291523!2d105.48763227717818!3d20.988286261973812!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b74d5000dd9%3A0x78f00cc4a35484b9!2zSMOyYSBM4bqhYywgVGjhuqFjaCBUaOG6pXQsIEjDoCBO4buZaSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2sus!4v1721135528710!5m2!1svi!2sus', 3.2);

INSERT INTO HOUSE (LANDLORD_ID, HOUSE_NAME, ADDRESS, DESCRIPTION_HOUSE, STATUS, LOCATION_ID) VALUES
(1, N'V Village', N'Ngõ 135 Đường Kim Bông', N' Chào mừng bạn đến với V Village - Nơi Tinh Hoa Cuộc Sống Hòa Quyện! 
 Bạn đang tìm kiếm một nơi ở lý tưởng tại Hòa Lạc? Với V Village, không chỉ là một căn phòng trọ, mà còn là điểm dừng chân an lành, nơi mà bạn có thể tận hưởng cuộc sống đẳng cấp và tiện nghi.
 Với môi trường xanh mát và yên bình, V Village mang lại không gian sống gần gũi với thiên nhiên, giúp bạn thoải mái tận hưởng những khoảnh khắc bình yên giữa cuộc sống hối hả.
 Vị trí đắc địa tại trung tâm Hòa Lạc, V Village kết nối dễ dàng với các trường đại học, khu vực mua sắm và các tiện ích công cộng khác, mang lại sự thuận tiện cho cuộc sống hàng ngày.
 Với các căn phòng trọ được trang bị đầy đủ tiện nghi và nội thất hiện đại, bạn sẽ tìm thấy sự thoải mái và tiện lợi ở V Village.
 Hãy đặt chân đến V Village ngay hôm nay để khám phá không gian sống đẳng cấp và 
 trải nghiệm cuộc sống an lành tại Hòa Lạc!', N'Còn phòng', 5),

(2, N'Chung cư Mini - Hòa Lạc Apartment', N'206 Cụm 1', N'THUÊ PHÒNG TRỌ SINH VIÊN Bạn sẽ nhận lại những gì ...?
Đến với Chung cư Mini - Hòa Lạc Apartment, bạn sẽ nhận được :<br>
1- Mức giá ưu đãi đặc biệt, nếu 2 - 3 bạn cùng ở thì chi phí sẽ rất hợp lý.<br>
2- Vị trí nằm giữa trung tâm khu đô thị vệ tinh Hoà Lạc<br>
3- Phòng có sự decor tỉ mỉ, đảm bảo công năng thuận tiện học tập, phòng siêu thoáng mát, view đồi núi mây xanh ngút tầm mắt ... Khuôn viên xanh mát mẻ hòa mình với môi trường.<br>
4- Hệ thống phòng ở đầy đủ nội thất tiện nghi, hiện đại đón đầu xu hướng với bếp, giường ngủ, điều hòa, máy giặt, tủ lạnh, ban công Loza... đặc biệt: TẤT CẢ ĐỀU MỚI TINH TINH, bạn sẽ là người đầu tiên sử dụng<br>
- Phù hợp với các bạn sinh viên ở từ 2 - 3 người<br>
- Lựa chọn hàng đầu, giúp các bạn tìm đươc nơi ở với chi phí vô cùng hợp lý mà lại nâng tầm cuộc sống<br>
- Phòng đẹp lịm tim - Xem là thích liền', N'Còn phòng', 12),

(3, N'Young House', N'Sau Nhà Văn Hóa thôn Thái Bình', 
N'Chào các bạn!! Young House tự hào giới thiệu tòa nhà mới nhất - Young House 9 tọa lạc tại Hòa Lạc! 
 Với mức giá siêu sinh viên chỉ từ 1,6 triệu đồng, Young House 9 mang đến cho bạn cơ hội trải nghiệm không gian sống hiện đại và tiện nghi.
Tại Young House 9, bạn sẽ được trải nghiệm:
- Phòng rộng rãi, thoải mái, được trang bị đầy đủ nội thất cao cấp như điều hòa, bình nóng lạnh, giường, tủ, bàn học,... (như bên dưới nhé!!!)
- Khung cảnh thiên nhiên xanh mướt, yên bình và lãng mạn, tạo nên một không gian sống lý tưởng.
- Nhiều ưu đãi hấp dẫn như chuyển đồ miễn phí, tặng nước uống và có cơ hội việc làm tại Young Group.
- Đến với Young House 9, bạn sẽ được trải nghiệm dịch vụ phòng ở mãi đỉnh tại Bình Yên.', N'Còn phòng', 2),

(4, N'New House', N'Lô 18, TĐC Bắc Phú Cát', N'New House Hòa Lạc cho thuê phòng trọ giá rẻ, chỉ từ 1tr6/phòng. 
Căn hộ mới xây dựng, được trang bị Phòng Cháy Chữa Cháy đầy đủ, đảm bảo an toàn. 
Mở cửa là thấy: Siêu Thị, Mixue Thạch Hòa, Tạp Hóa, Hiệu Thuốc, Cửa hàng điện thoại, TocoToco, 
Chợ Cóc ngay bên cạnh thuận tiện cho việc mua đồ ăn nấu nướng tại phòng, cách Sân bóng nhân tạo 200m,...', N'Còn phòng', 9),

(5, N'Trọ Thảo Nguyên', N'Ngõ 28 đường Tân Xã', N'Nhà trọ Thảo Nguyên tọa lạc tại ngõ 28 đường Tân Xã, 
mang đến cho bạn một không gian sống yên tĩnh và thoáng mát. Mỗi phòng đều rộng rãi, với cửa sổ lớn đón ánh sáng tự nhiên, 
tạo cảm giác thoải mái và dễ chịu. Nội thất trong phòng được trang bị đầy đủ gồm giường, tủ quần áo, bàn học, điều hòa và máy giặt. 
Nhà vệ sinh riêng biệt có bình nóng lạnh, đảm bảo sự tiện nghi tối đa cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ có nhiều cây xanh, 
tạo nên một môi trường sống trong lành. Ngoài ra, nhà trọ gần các tiện ích như cửa hàng tiện lợi, siêu thị, và nhà hàng, 
giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.', N'Còn phòng', 6),

(6, N'Trọ Bình An', N'Khu đô thị Bình Yên', N'Nhà trọ Bình An nằm trong khu đô thị Bình Yên, 
mang đến một không gian sống tiện nghi và thoải mái. Các phòng trọ được thiết kế hiện đại với ban công riêng, 
giúp bạn có thể thư giãn sau những giờ làm việc căng thẳng. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, 
bàn làm việc, điều hòa, và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh khép kín có máy nước nóng,
mang lại sự tiện nghi tối đa. Nhà trọ gần các cửa hàng tiện lợi, khu vực ăn uống và trạm xe buýt, rất thuận tiện cho việc di chuyển. 
Hệ thống an ninh với bảo vệ 24/7 đảm bảo an toàn tuyệt đối cho bạn.', N'Còn phòng', 2),

(7, N'Trọ Cổng Phụ', N'Cổng phụ đại học FPT', N'Nhà trọ Cổng Phụ nằm ngay cạnh cổng phụ đại học FPT, 
là lựa chọn lý tưởng cho sinh viên. Phòng trọ mới xây dựng, sạch sẽ và thoáng mát, 
được trang bị đầy đủ nội thất hiện đại bao gồm giường, tủ quần áo, bàn học, điều hòa và máy giặt. 
Mỗi phòng đều có nhà vệ sinh riêng với máy nước nóng, đảm bảo sự tiện nghi cho sinh hoạt hàng ngày. 
Khu vực xung quanh có an ninh tốt, nhiều quán cà phê, cửa hàng tiện lợi và các dịch vụ ăn uống, 
tạo điều kiện thuận lợi cho cuộc sống sinh viên.', N'Còn phòng', 1),

(8, N'Trọ Thanh Thúy', N'Ngõ 15 đường Đồng Trúc', N'Nhà trọ Thanh Thúy cung cấp một không gian sống tiện nghi với mức giá hợp lý. 
Các phòng rộng rãi, thoáng mát, được trang bị đầy đủ nội thất mới bao gồm giường ngủ, tủ quần áo, bàn làm việc, 
điều hòa và máy giặt. Nhà vệ sinh riêng biệt có máy nước nóng, giúp bạn luôn cảm thấy thoải mái. Khu vực xung quanh nhà trọ yên tĩnh,
gần khu công nghiệp và các tiện ích công cộng như siêu thị, cửa hàng tiện lợi và nhà hàng. An ninh được đảm bảo 24/7 với 
hệ thống bảo vệ hiện đại.', N'Còn phòng', 3),

(9, N'Trọ Kim Quan', N'Ngõ 2 đường Kim Quan', N'Nhà trọ Kim Quan nằm tại ngõ 2 đường Kim Quan, 
mang đến cho bạn một không gian sống xanh mát và yên tĩnh. Phòng trọ được thiết kế với không gian mở, 
có cửa sổ lớn, giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, 
tủ quần áo, bàn làm việc, điều hòa và máy giặt, tất cả đều được trang bị đầy đủ và mới. Nhà vệ sinh riêng 
với máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ gần các trường đại học, khu vực
mua sắm và các tiện ích công cộng khác, mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.', N'Còn phòng', 5),

(10, N'Trọ Tân Xã', N'Số 10 đường Tân Xã', N'Nhà trọ Tân Xã tọa lạc tại số 10 đường Tân Xã, mang đến cho bạn 
một không gian sống hiện đại và tiện nghi. Các phòng rộng rãi, thoáng mát, có view đẹp, giúp bạn luôn cảm thấy
thư thái và thoải mái. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa, máy giặt và 
máy nước nóng, tất cả đều mới và chất lượng cao. Khu vực xung quanh nhà trọ an ninh tốt, nhiều cửa hàng tiện lợi, 
siêu thị và nhà hàng, giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.', N'Còn phòng', 6),

(11, N'Trọ Chợ Hòa Lạc', N'Ngõ 7 đường Chợ Hòa Lạc', N'Nhà trọ Chợ Hòa Lạc nằm tại ngõ 7 đường Chợ Hòa Lạc, 
mang đến cho bạn một không gian sống tiện nghi và thoải mái. Phòng trọ được thiết kế với không gian mở, có cửa sổ lớn,
giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc,
điều hòa và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi 
cho sinh hoạt hàng ngày. Nhà trọ gần chợ và các tiện ích công cộng như siêu thị, cửa hàng tiện lợi và nhà hàng, 
mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.', N'Còn phòng', 7),

(12, N'Trọ Cây Xăng 39', N'Gần cây xăng 39', N'Nhà trọ Cây Xăng 39 tọa lạc gần cây xăng 39, mang đến cho bạn một 
không gian sống tiện nghi và thoải mái. Các phòng rộng rãi, thoáng mát, được thiết kế với không gian mở, có cửa sổ lớn,
giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa 
và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. 
Nhà trọ gần cây xăng và các cửa hàng tiện lợi, giúp bạn dễ dàng tiếp cận các dịch vụ cần thiết.', N'Còn phòng', 8),

(13, N'Trọ Thôn 3 Thạch Hòa', N'Ngõ 4 đường Thôn 3 Thạch Hòa', N'Nhà trọ Thôn 3 Thạch Hòa nằm tại ngõ 4 đường Thôn 
3 Thạch Hòa, mang đến cho bạn một không gian sống yên tĩnh và gần gũi với thiên nhiên. Phòng trọ được thiết kế với không gian mở, 
có cửa sổ lớn, giúp bạn luôn cảm thấy thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc,
điều hòa và máy giặt, tất cả đều mới và chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. 
Khu vực xung quanh nhà trọ có nhiều cây xanh, tạo nên một môi trường sống trong lành, gần các tiện ích công cộng như siêu thị, 
cửa hàng tiện lợi và nhà hàng.', N'Còn phòng', 9),
(14, N'Trọ Thôn 4 Thạch Hòa', N'Số 5 đường Thôn 4 Thạch Hòa', N'Nhà trọ Thôn 4 Thạch Hòa tọa lạc tại số 5 đường Thôn 4 Thạch Hòa, 
mang đến cho bạn một không gian sống tiện nghi và thoải mái. Các phòng rộng rãi, thoáng mát, có cửa sổ lớn, giúp bạn luôn cảm thấy
thoáng đãng và dễ chịu. Nội thất trong phòng bao gồm giường ngủ, tủ quần áo, bàn làm việc, điều hòa và máy giặt, tất cả đều mới và 
chất lượng cao. Nhà vệ sinh riêng biệt có máy nước nóng, đảm bảo tiện nghi cho sinh hoạt hàng ngày. Khu vực xung quanh nhà trọ an ninh tốt, 
gần các trường đại học, khu vực mua sắm và các tiện ích công cộng khác, 
mang lại sự thuận tiện cho cuộc sống hàng ngày của bạn.', N'Còn phòng', 10);

INSERT INTO ROOM (HOUSE_ID, ROOM_NUMBER, STATUS, PRICE, AREA) VALUES
(1, 101,  1, 3000000, 35),(2, 501,  1, 3500000, 35),(3, 303,  1, 3000000, 30),
(4, 404,  1, 2600000, 30),(4, 201,  1, 2300000, 25),(5, 101, 1, 1300000, 20),
(5, 102, 1, 1500000, 22),(5, 201, 1, 1700000, 25),(6, 101, 1, 1200000, 18),
(6, 102, 1, 1400000, 20),(7, 301, 1, 1500000, 20),(8, 102, 1, 1200000, 20),
(9, 102, 1, 1800000, 25),(10, 102, 1, 4500000, 32),(11, 103, 1, 1200000, 20),
(12, 102, 1, 1800000, 25),(13, 201, 1, 1600000, 20),(14, 102, 1, 1200000, 17),
(1,102,1,1700000,20),(1,103,1,2000000,23),(2,101,1,3000000,25),(2,102,1,3100000,26);

INSERT INTO utilities (utilities) VALUES
(N'Điều hòa'),
(N'Wifi'),
(N'Nóng lạnh'),
(N'Bàn Học'),
(N'Giường'),
(N'Tủ quần áo'),
(N'Bàn bếp'),
(N'Quạt'),
(N'Tủ lạnh'),
(N'Hệ thống hút mùi'),
(N'Bồn rửa');

INSERT INTO room_utilities (room_id,utilities_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,10),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,10),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,10),
(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,10),
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,10),
(6, 1),(6, 2),(6, 3),(6, 4),(6, 5),
(7, 1),(7, 2),(7, 3),(7, 4),(7, 5),(7, 8),(7, 11),
(8, 1),(8, 2),(8, 3),(8, 4),(8, 5),(8, 6),(8, 8),(8, 11),
(9, 1),(9, 2),(9, 3),(9, 8),
(10, 1),(10, 2),(10, 3),(10, 5),(10, 8), 
(11, 1),(11, 2),(11, 3),(11, 4),(11, 5),(11, 8),
(12, 1),(12, 2),(12, 3),(12, 4),(12, 5),(12, 8),
(13, 1),(13, 2),(13, 3),(13, 4),(13, 5),(13, 8),
(14, 1),(14, 2),(14, 3),(14, 4),(14, 5),(14, 6),(14, 7),
(14, 8),(14, 9),(14, 10),(14, 11),
(15, 1),(15, 2),(15, 3),(15, 5),
(16, 1),(16, 2),(16, 3),(16, 4),(16, 5),(16, 8),(16, 11),
(17, 1),(17, 2), (17, 3),(17, 5),(17, 8),
(18, 1),(18, 2), (18, 3), (18, 5),(18, 8),
(19,1),(19,2),(19,3),(19,4),(19,5),
(20,1),(20,2),(20,3),(20,6),(20,5),(20,8),
(21,1),(21,2),(21,3),(21,4),(21,5),(21,6),(21,8),
(22,1),(22,2),(22,3),(22,4),(22,5),(22,6),(22,8),(22,11);

INSERT INTO HOUSE_IMAGE (HOUSE_ID ,IMAGE_URL) 
VALUES 
(1,'house1.1.jpg'),(1,'house1.2.jpg'),(1,'house1.3.jpg'),(1,'house1.4.jpg'),(1,'house1.5.jpg'),
(1,'house1.6.jpg'),(1,'house1.7.jpg'),(1,'house1.8.jpg'),(1,'house1.9.jpg'),(1,'house1.10.jpg'),
(2,'house2.1.jpg'),(2,'house2.2.jpg'),(2,'house2.3.jpg'),(2,'house2.4.jpg'),(2,'house2.5.jpg'),
(2,'house2.6.jpg'),(3,'house3.1.jpg'),(3,'house3.2.jpg'),(3,'house3.3.jpg'),(4,'house4.1.jpg'),
(4,'house4.2.jpg'),(4,'house4.3.jpg'),(4,'house4.4.jpg'),(4,'house4.5.jpg'),(5,'house5.1.jpg'),
(5,'house5.2.jpg'),(6,'house6.1.jpg'),(6,'house6.2.jpg'), (6,'house6.3.jpg'),(7,'house7.1.jpg'),
(7,'house7.2.jpg'),(8,'house8.1.jpg'),(8,'house8.2.jpg'),(9,'house9.1.jpg'),(9,'house9.2.jpg'),
(10,'house10.1.jpg'),(10,'house10.2.jpg'),(11,'house11.1.jpg'),(11,'house4.2.jpg'),(12,'house12.1.jpg'),
(12,'house12.2.jpg'),(13,'house13.1.jpg'),(13,'house13.2.jpg'),(14,'house14.1.jpg'),(14,'house14.2.jpg'),
(1,'house1_room101.2.jpg'),(1,'house1_room101.3.jpg'),(1,'house1_room101.4.jpg'),(1,'house1_room101.5.jpg'),
(2,'house2_room501.1.jpg'),(2,'house2_room501.2.jpg'),(2,'house2_room501.3.jpg'),(2,'house2_room501.4.jpg');

--INSERT INTO ORDERS ([tenant_id], [landlord_id], [status], [room_id], [order_date], [note]) VALUES 
--(1, 1, N'Approve', 1, CAST(N'2024-07-25' AS Date), N'Hãy để ý điện thoại chờ liên hệ nhé');
--(1,1,N'Cancel',1,'2024-07-02 12:30:45.000'),
--(1,4,N'Approve',5,'2024-07-03 12:30:45.000'),
--(1,2,N'Reject',2,'2024-07-04 12:30:45.000');
--(1,4,N'Chờ xác nhận',4,'2024-07-05 12:30:45.000'),
--(1,3,N'Cancel',3,'2024-07-06 12:30:45.000');

INSERT INTO HISTORY_ORDER(order_id, [status]) values (1, N'Pending'),(1, N'Approve')

INSERT INTO UPGRADE (type, landlord_id,transaction_id,amount,description,error_code,ctt,bank_code,time_transaction,status) VALUES 
--(N'Cơ bản',1,'56141467',499000,N'Thanh toan don hang:56141467',0,'14502798','NCB','2024-07-09 20:35:52',1), 
(N'Tiêu chuẩn',2,'20205357',899000,N'Thanh toan don hang:20205357',0,'14502837','NCB','2024-07-09 20:59:50',1),
(N'Nâng Cao',3,'89983365',1499000,N'Thanh toan don hang:89983365',0,'14502838','NCB','2024-07-09 21:02:09',1);
--(N'Nâng Cao',1,'56141467',1499000,N'Thanh toan don hang:56141467',0,'14502798','NCB','2024-07-09 21:02:09',1);


INSERT INTO REPORT (USER_ID,REPORT_PROBLEM,REPORT_DESCRIPTION,status) VALUES 
(3,N'Có lỗi phần mềm',N'Phần mềm này có lỗi nghiêm trọng',1),
(3,N'Thông tin về trọ không đúng',N'Thông tin được đăng không chính xác với thực tế',0);

INSERT INTO REPLY_REPORT ( admin_id, report_id, reply_content) VALUES(1,1,N'Cảm ơn bạn đã gửi báo cáo về lỗi này');

INSERT INTO FEEDBACK (tenant_id, house_id,feedback_date,rating_star,feedback_content) VALUES 
(1,1,'2024-05-28 12:30:45.000',4,N'Phòng rộng rãi sạch sẽ'),
(2,2,'2024-05-28 12:30:45.000',5,N'Phòng đẹp lắm');

INSERT INTO REPLY_FEEDBACK (feedback_id, landlord_id,reply_date, reply_content) VALUES 
(1,1,'2024-05-28 12:30:45.000',N'Cảm ơn đánh giá của bạn'),
(2,2,'2024-05-28 12:30:45.000',N'Cảm ơn bạn đã đánh giá');

INSERT INTO WISHLIST (TENANT_ID,house_id) VALUES (1,1);







----------------------------------------------------------------------------------------
SELECT * FROM USERS
SELECT * FROM TENANT
SELECT * FROM ADMIN
SELECT * FROM LANDLORD
SELECT * FROM AVATAR
SELECT * FROM ROOM
SELECT * FROM room_utilities
SELECT * FROM utilities
SELECT * FROM HOUSE
SELECT * FROM HOUSE_IMAGE
SELECT * FROM REPORT
SELECT * FROM REPLY_REPORT
SELECT * FROM UPGRADE
SELECT * FROM WISHLIST
SELECT * FROM ORDERS
SELECT * FROM HISTORY_ORDER
SELECT * FROM FEEDBACK
SELECT * FROM REPLY_FEEDBACK
SELECT * FROM PROPERTY_LOCATION






update orders set status = 'CheckOut', isConfirm = null where room_id = 2 and tenant_id = 1 








drop table AVATAR
drop table REPLY_REPORT
drop table REPORT
drop table UPGRADE
drop table REPLY_FEEDBACK
drop table FEEDBACK
drop table WISHLIST
drop table HISTORY_ORDER
drop table ORDERS
drop table HOUSE_IMAGE
drop table room_utilities
drop table utilities
drop table ROOM
drop table HOUSE
drop table PROPERTY_LOCATION
drop table TENANT
drop table ADMIN
drop table LANDLORD
drop table BLOG_POSTS
drop table USERS






SELECT TOP 1 * 
FROM orders 
ORDER BY order_id DESC;


update orders set status = 'CheckOut' where room_id = 1 and tenant_id = 1 and order_id = 1
update orders set status = 'Cancel' where  order_id = 3 
update ROOM set status = 0 where room_id = 1

update orders set status = 'Pending' where  order_id = 1 

select * from Orders where tenant_id = 1 and status = 'Cancel' or status = 'Reject' or status = 'CheckOut'








SELECT location_id, location_name FROM PROPERTY_LOCATION
SELECT * FROM users where USERS.IS_BAN = 0

--create table test(
--	test_id int primary key identity(1,1),
--	create_date datetime default getdate(),
--	update_date datetime default getdate(),
--	content nvarchar(255)
--)
--insert into test(content) values (N'Test 1'),('Test 2'),('Test 3')

--select * from test

--drop table test

--update test set update_date = '2024-06-15 17:45:23' where test_id = 2

SELECT HOUSE.*, PROPERTY_LOCATION.distance_km
FROM HOUSE INNER JOIN
PROPERTY_LOCATION ON HOUSE.location_id = PROPERTY_LOCATION.location_id


-- thống kê theo tháng----------------------
SELECT 
    YEAR(time_transaction) AS TransactionYear,
    MONTH(time_transaction) AS TransactionMonth,
    COUNT(*) AS TotalTransactions,
    SUM(amount) AS TotalAmount
FROM 
    upgrade
GROUP BY 
    YEAR(time_transaction), MONTH(time_transaction)
ORDER BY 
    TransactionYear, TransactionMonth;


---------------- thống kê theo tháng hiện tại

SELECT 
    YEAR(GETDATE()) AS TransactionYear,
    MONTH(GETDATE()) AS TransactionMonth,
    COUNT(*) AS TotalTransactions,
    SUM(amount) AS TotalAmount
FROM 
    upgrade
WHERE
    YEAR(time_transaction) = YEAR(GETDATE())
    AND MONTH(time_transaction) = MONTH(GETDATE());

-- thống kê theo năm-------------------
SELECT 
    YEAR(time_transaction) AS TransactionYear,
    COUNT(*) AS TotalTransactions,
    SUM(amount) AS TotalAmount
FROM 
    upgrade
GROUP BY 
    YEAR(time_transaction)
ORDER BY 
    TransactionYear;

-------- thống kê theo năm hiện tại----------

SELECT 
    YEAR(GETDATE()) AS TransactionYear,
    COUNT(*) AS TotalTransactions,
    SUM(amount) AS TotalAmount
FROM 
    upgrade
WHERE
    YEAR(time_transaction) = YEAR(GETDATE())
GROUP BY 
    YEAR(time_transaction)
ORDER BY 
    TransactionYear;
	-----------------------------------------------
SELECT COUNT(*) as allorder
FROM orders

