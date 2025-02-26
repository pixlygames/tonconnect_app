CREATE TABLE IF NOT EXISTS wallet_mappings (
    citizen_id VARCHAR(50) PRIMARY KEY,
    wallet_address VARCHAR(100) UNIQUE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
