CREATE VIEW v1 (StadiumName, ArenaName, Income, SoldSeatNum)
  AS
  SELECT Seat_Arena_Stadium_Name, Seat_Arena_Name, SUM(Price), Count(Price)
    FROM Ticket;

create view v2(City, product_type, active_user_count, active_ad_count, proportion)
	as select User.City,
			Product.Type, 
			count(select User.ID 
					from User, Advertisement
                    where User.ID = Advertisement.User_creates_ID),
			count(select Advertisement.ID
					from Advertisement, Product
                    where Advertisement.Product_ID = Product.ID AND Product.Existence = TRUE),
			count(select Advertisement.ID
					from Advertisement, Product
                    where Advertisement.Product_ID = Product.ID AND Product.Existence = FALSE)
			/
            count(select Advertisement.ID
					from Advertisement)
		from User, Product, Advertisement
		where User.ID = Advertisement.User_creates_ID AND Advertisement.Product_ID = Product.ID
        group by User.City;