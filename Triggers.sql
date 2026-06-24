-- Trigger: Reduce Product Stock After Order
DELIMITER //

CREATE TRIGGER trg_reduce_stock
AFTER INSERT
ON order_items

FOR EACH ROW

BEGIN

    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

END //

DELIMITER ;

-- Trigger: Prevent Negative Stock
DELIMITER //

CREATE TRIGGER trg_check_stock
BEFORE INSERT
ON order_items

FOR EACH ROW

BEGIN

    DECLARE available_stock INT;

    SELECT stock
    INTO available_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient Stock';
    END IF;

END //

DELIMITER ;

-- Performance Optimization
-- Indexing: Index on Foreign Keys
CREATE INDEX idx_orders_user
ON orders(user_id);

CREATE INDEX idx_orderitems_order
ON order_items(order_id);

CREATE INDEX idx_orderitems_product
ON order_items(product_id);

CREATE INDEX idx_payments_order
ON payments(order_id);

-- Index on Payment Status
CREATE INDEX idx_payment_status
ON payments(status);


-- Query Optimization
-- Before Optimization
SELECT *
FROM orders
WHERE user_id = 5;

-- After Optimization
CREATE INDEX idx_orders_userid
ON orders(user_id);