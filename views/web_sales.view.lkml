view: web_sales {
  sql_table_name: "DATA_DEV"."WEB_SALES"
    ;;

  dimension: ws_bill_addr_sk {
    type: number
    sql: ${TABLE}."WS_BILL_ADDR_SK" ;;
  }

  dimension: ws_bill_cdemo_sk {
    type: number
    sql: ${TABLE}."WS_BILL_CDEMO_SK" ;;
  }

  dimension: ws_bill_customer_sk {
    type: number
    sql: ${TABLE}."WS_BILL_CUSTOMER_SK" ;;
  }

  dimension: ws_bill_hdemo_sk {
    type: number
    sql: ${TABLE}."WS_BILL_HDEMO_SK" ;;
  }

  dimension: ws_coupon_amt {
    type: number
    sql: ${TABLE}."WS_COUPON_AMT" ;;
  }

  dimension: ws_ext_discount_amt {
    type: number
    sql: ${TABLE}."WS_EXT_DISCOUNT_AMT" ;;
  }

  dimension: ws_ext_list_price {
    type: number
    sql: ${TABLE}."WS_EXT_LIST_PRICE" ;;
  }

  dimension: ws_ext_sales_price {
    type: number
    sql: ${TABLE}."WS_EXT_SALES_PRICE" ;;
  }

  dimension: ws_ext_ship_cost {
    type: number
    sql: ${TABLE}."WS_EXT_SHIP_COST" ;;
  }

  dimension: ws_ext_tax {
    type: number
    sql: ${TABLE}."WS_EXT_TAX" ;;
  }

  dimension: ws_ext_wholesale_cost {
    type: number
    sql: ${TABLE}."WS_EXT_WHOLESALE_COST" ;;
  }

  dimension: ws_item_sk {
    type: number
    sql: ${TABLE}."WS_ITEM_SK" ;;
  }

  dimension: ws_list_price {
    type: number
    sql: ${TABLE}."WS_LIST_PRICE" ;;
  }

  dimension: ws_net_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}."WS_NET_PAID" ;;
  }

  dimension: ws_net_paid_inc_ship {
    type: number
    sql: ${TABLE}."WS_NET_PAID_INC_SHIP" ;;
  }

  dimension: ws_net_paid_inc_ship_tax {
    type: number
    sql: ${TABLE}."WS_NET_PAID_INC_SHIP_TAX" ;;
  }

  dimension: ws_net_paid_inc_tax {
    type: number
    sql: ${TABLE}."WS_NET_PAID_INC_TAX" ;;
  }

  dimension: ws_net_profit {
    type: number
    sql: ${TABLE}."WS_NET_PROFIT" ;;
  }

  dimension: ws_order_number {
    type: number
    sql: ${TABLE}."WS_ORDER_NUMBER" ;;
  }

  dimension: ws_promo_sk {
    type: number
    sql: ${TABLE}."WS_PROMO_SK" ;;
  }

  dimension: ws_quantity {
    type: number
    sql: ${TABLE}."WS_QUANTITY" ;;
  }

  measure: ws_sales_price {
    type: sum
    sql: ${TABLE}."WS_SALES_PRICE" ;;
  }

  dimension: ws_ship_addr_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_ADDR_SK" ;;
  }

  dimension: ws_ship_cdemo_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_CDEMO_SK" ;;
  }

  dimension: ws_ship_customer_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_CUSTOMER_SK" ;;
  }

  dimension: ws_ship_date_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_DATE_SK" ;;
  }

  dimension: ws_ship_hdemo_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_HDEMO_SK" ;;
  }

  dimension: ws_ship_mode_sk {
    type: number
    sql: ${TABLE}."WS_SHIP_MODE_SK" ;;
  }

  dimension: ws_sold_date_sk {
    type: number
    sql: ${TABLE}."WS_SOLD_DATE_SK" ;;
  }

  dimension: ws_sold_time_sk {
    type: number
    sql: ${TABLE}."WS_SOLD_TIME_SK" ;;
  }

  dimension: ws_warehouse_sk {
    type: number
    sql: ${TABLE}."WS_WAREHOUSE_SK" ;;
  }

  dimension: ws_web_page_sk {
    type: number
    sql: ${TABLE}."WS_WEB_PAGE_SK" ;;
  }

  dimension: ws_web_site_sk {
    type: number
    sql: ${TABLE}."WS_WEB_SITE_SK" ;;
  }

  dimension: ws_wholesale_cost {
    type: number
    sql: ${TABLE}."WS_WHOLESALE_COST" ;;
  }

  #custom dimentions
  dimension: is_ytd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter store_sales.datefilter %})
      and
      ${date_dim.d_date} <= {% parameter store_sales.datefilter %}
      ;;
  }
  dimension: is_mtd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter store_sales.datefilter %})
      and
      substring(${date_dim.d_month},6,2) = month({% parameter store_sales.datefilter %})
      and
      ${date_dim.d_date} <= {% parameter store_sales.datefilter %}
      ;;
  }
  dimension: is_sply_ytd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter store_sales.datefilter %})-1
      and
      ${date_dim.d_date}<= TO_DATE({% parameter store_sales.datefilter %})-365
      ;;
  }
  dimension: is_sply_mtd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter store_sales.datefilter %})-1
      and
      substring(${date_dim.d_month},6,2) = month({% parameter store_sales.datefilter %})
      and
      ${date_dim.d_date} <= TO_DATE({% parameter store_sales.datefilter %})-365
      ;;
  }
  measure: ws_sales_price_ytd {
    type: sum
    sql: ${TABLE}."WS_SALES_PRICE" ;;
    filters: [is_ytd: "yes"]
  }
  measure: ws_sales_price_mtd {
    type: sum
    sql: ${TABLE}."WS_SALES_PRICE" ;;
    filters: [is_mtd: "yes"]
  }
  measure: ws_sales_price_sply_ytd {
    type: sum
    sql: ${TABLE}."WS_SALES_PRICE" ;;
    filters: [is_sply_ytd: "yes"]
  }
  measure: ws_sales_price_sply_mtd {
    type: sum
    sql: ${TABLE}."WS_SALES_PRICE" ;;
    filters: [is_sply_mtd: "yes"]
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
