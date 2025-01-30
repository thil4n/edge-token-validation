CREATE TABLE revoked_tokens (
    id SERIAL PRIMARY KEY,
    token TEXT
);


INSERT INTO revoked_tokens (token)
VALUES
    ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNzAwMDAwMDAwLCJleHAiOjE5MDAwMDAwMDAsInJvbGUiOiJhZG1pbiJ9.kqFw6txKAXhzfrAdk04J4QBLf3Lzx3LGXQhWljA2VLY
'),
