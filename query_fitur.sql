--Menampilkan total order setiap bulan--

SELECT
    DATE_PART('year', order_time) AS tahun,
    DATE_PART('month', order_time) AS bulan,
    COUNT(*) AS total_order
FROM "order"
GROUP BY tahun, bulan
ORDER BY tahun, bulan;

--menampilkan customer yang paling banyak order tiap bulan--
SELECT tahun, bulan, customer_name, total_order
FROM (
    SELECT
        DATE_PART('year', o.order_time) AS tahun,
        DATE_PART('month', o.order_time) AS bulan,
        u.name AS customer_name,
        COUNT(*) AS total_order,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_PART('year', o.order_time),
                         DATE_PART('month', o.order_time)
            ORDER BY COUNT(*) DESC
        ) AS ranking
    FROM orders o
    JOIN customer c ON o.customer_id = c.customer_id
    JOIN users u ON c.customer_id = u.id
    GROUP BY tahun, bulan, customer_name
) AS ranked
WHERE ranking = 1
ORDER BY tahun, bulan;


--menampilkan lokasi terbanyak di jemput--
SELECT 
    pickup_location AS lokasi,
    COUNT(*) AS total_order
FROM orders
GROUP BY pickup_location
ORDER BY total_order DESC;

--menampilkan jam paling sering--
SELECT
    EXTRACT(HOUR FROM order_time) AS jam,
    COUNT(*) AS total_order
FROM orders
GROUP BY jam
ORDER BY total_order DESC;  


--menapilkan jumlah customer yang login dan logout--
SELECT COUNT(*) AS total_customer_login
FROM (
    SELECT DISTINCT ON (u.id)
        u.id,
        l.activity_type
    FROM users u
    JOIN user_activity_log l ON l.user_id = u.id
    WHERE u.role = 'customer'
    ORDER BY u.id, l.activity_time DESC
) AS last_activity
WHERE activity_type = 'login'; //ganti logout
