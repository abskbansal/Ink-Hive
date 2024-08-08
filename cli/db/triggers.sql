DELIMITER //

CREATE TRIGGER trig_block_customer_account 
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    IF NEW.attempts_left = 0 AND NEW.block_time IS NULL THEN
        SET NEW.status = 'blocked';
        SET NEW.block_time = NOW();
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trig_update_qty_before
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    IF NEW.qty = 0 THEN
        SET NEW.qty = 100;
    END IF;
END;
//

DELIMITER ;
