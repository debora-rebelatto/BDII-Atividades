CREATE OR REPLACE FUNCTION remove_product()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Product WHERE id = OLD.product_id;
    DELETE FROM Stock WHERE product_id = OLD.product_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
