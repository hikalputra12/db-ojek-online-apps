
Table users {
  user_id int [pk]
  name varchar
  email varchar
  password varchar
  role enum('admin','customer','driver')
  create_at timestamp
  update_at timestamp
}

Table customer{
  customer_id int [pk]
  address varchar
  phone_number varchar
}
Table user_activity_log{
  activity_id int [pk]
  user_id int
  activity_type enum('login', 'logout')
  activity_time timestamp
}

Table driver{
  driver_id int [pk]
  phone_number varchar
  vehicle_number varchar
  type_of_vehicle varchar
}
Table order{
  order_id int [pk]
  customer_id int
  driver_id int
  pickup_location varchar
  destination_location varchar
  distance float
  cost int
  status_order enum
  order_time timestamp
  finish_time timestamp
}

Table travel_history {
  travel_history_id int [pk]
  order_id int
  customer_id int
  travel_time timestamp
}

Table driver_monthly_history {
  driver_monthly_history_id int [pk]
  drive_id int
  month int
  year int
  total_orders int
}



Ref: "users"."user_id" < "customer"."customer_id"

Ref: "users"."user_id" < "driver"."driver_id"

Ref: "customer"."customer_id" < "order"."customer_id"


Ref: "order"."order_id" < "travel_history"."order_id"

Ref: "driver"."driver_id" < "driver_monthly_history"."drive_id"



Ref: "user_activity_log"."user_id" < "users"."user_id"



Ref: "driver"."driver_id" < "order"."driver_id"



