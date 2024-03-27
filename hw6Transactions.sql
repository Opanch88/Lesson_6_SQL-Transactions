-- ЗАДАНИЕ 1

DELIMITER $$
CREATE FUNCTION GetFormatDays(secs int unsigned) RETURNS VARCHAR(255) DETERMINISTIC
begin
    DECLARE days int unsigned;
    DECLARE hours int unsigned;
    DECLARE mins int unsigned;
    DECLARE result VARCHAR(255) default '';
    
    SET days = floor(secs / (3600*24));
    SET secs = secs % (3600*24);
    SET hours = floor(secs / 3600);
    SET secs = secs % 3600;
    SET mins = floor(secs / 60);
    SET secs = secs % 60;
    
    if days > 0 then
		SET result = concat(days, ' days');
	end if;
	if hours > 0 then
		SET result = concat(result,' ',hours,' hours');
	end if;
	if mins > 0 then
		SET result = concat(result, ' ', mins, ' minutes');
	end if;
	if secs > 0 then
		SET result = concat(result,' ', secs, ' seconds');
	end if;
	return result;
END $$
DELIMITER ;

select GetFormatDays(12354894);

-- ЗАДАНИЕ 2
drop procedure if exists TableEvenNumbers;
DROP TEMPORARY TABLE IF EXISTS even_numbers;
DELIMITER $$
CREATE PROCEDURE TableEvenNumbers(IN N INT)
BEGIN
	DECLARE counter INT DEFAULT 1;
	CREATE temporary table if not exists even_numbers (num int);
    
    WHILE counter <= N DO
		if counter % 2 = 0 then
			insert into even_numbers (num)
				values (counter);
		end if;
        SET counter = counter + 1;
    END WHILE;    
END $$
DELIMITER ;

call TableEvenNumbers(44);
select * from even_numbers;
