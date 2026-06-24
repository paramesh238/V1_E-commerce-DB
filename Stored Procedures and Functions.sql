-- Stored Procedure: Get Customer Orders
DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(IN p_user_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date
    FROM orders o
    WHERE o.user_id = p_user_id;
END $$

DELIMITER ;

-- Execute
CALL GetCustomerOrders(2);
