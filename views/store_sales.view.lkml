view: store_sales {
  sql_table_name: "DATA_DEV"."STORE_SALES"
    ;;

  dimension: ss_addr_sk {
    type: number
    sql: ${TABLE}."SS_ADDR_SK" ;;
  }

  dimension: ss_cdemo_sk {
    type: number
    sql: ${TABLE}."SS_CDEMO_SK" ;;
  }

  dimension: ss_coupon_amt {
    type: number
    sql: ${TABLE}."SS_COUPON_AMT" ;;
  }

  dimension: ss_customer_sk {
    type: number
    sql: ${TABLE}."SS_CUSTOMER_SK" ;;
  }

  dimension: ss_ext_discount_amt {
    type: number
    sql: ${TABLE}."SS_EXT_DISCOUNT_AMT" ;;
  }

  dimension: ss_ext_list_price {
    type: number
    sql: ${TABLE}."SS_EXT_LIST_PRICE" ;;
  }

  dimension: ss_ext_sales_price {
    type: number
    sql: ${TABLE}."SS_EXT_SALES_PRICE" ;;
  }

  dimension: ss_ext_tax {
    type: number
    sql: ${TABLE}."SS_EXT_TAX" ;;
  }

  dimension: ss_ext_wholesale_cost {
    type: number
    sql: ${TABLE}."SS_EXT_WHOLESALE_COST" ;;
  }

  dimension: ss_hdemo_sk {
    type: number
    sql: ${TABLE}."SS_HDEMO_SK" ;;
  }

  dimension: ss_item_sk {
    type: number
    sql: ${TABLE}."SS_ITEM_SK" ;;
  }

  dimension: ss_list_price {
    type: number
    sql: ${TABLE}."SS_LIST_PRICE" ;;
  }

  dimension: ss_net_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}."SS_NET_PAID" ;;
  }

  dimension: ss_net_paid_inc_tax {
    type: number
    sql: ${TABLE}."SS_NET_PAID_INC_TAX" ;;
  }

  dimension: ss_net_profit {
    type: number
    sql: ${TABLE}."SS_NET_PROFIT" ;;
  }

  dimension: ss_promo_sk {
    type: number
    sql: ${TABLE}."SS_PROMO_SK" ;;
  }

  dimension: ss_quantity {
    type: number
    sql: ${TABLE}."SS_QUANTITY" ;;
  }

  measure: ss_sales_price {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE" ;;
  }

  dimension: ss_sold_date_sk {
    type: number
    sql: ${TABLE}."SS_SOLD_DATE_SK" ;;
  }

  dimension: ss_sold_time_sk {
    type: number
    sql: ${TABLE}."SS_SOLD_TIME_SK" ;;
  }

  dimension: ss_store_sk {
    type: number
    sql: ${TABLE}."SS_STORE_SK" ;;
  }

  dimension: ss_ticket_number {
    type: number
    sql: ${TABLE}."SS_TICKET_NUMBER" ;;
  }

  dimension: ss_wholesale_cost {
    type: number
    sql: ${TABLE}."SS_WHOLESALE_COST" ;;
  }
  dimension: Current_Year {
    type: string
    sql: Current_date;;
  }
  dimension: is_ytd{
    type: yesno
    sql:
      ${date_dim.d_year} = year(current_date)-18
      and
      ${date_dim.d_month} <= month(current_date)
      and
      ${date_dim.d_date} <= day(current_date)
      ;;
  }
 dimension: customdate{
    type: string
    sql: ${date_dim.d_date} ;;
  }
  dimension: customdatess{
    type: string
    sql: substring(${date_dim.d_date},9,2) ;;
  }
  dimension: custommonth{
    type: string
    sql: ${date_dim.d_month} ;;
  }
  dimension: customyear{
    type: string
    sql: ${date_dim.d_year} ;;
  }
  dimension: customyear_minus{
    type: string
    sql: year(current_date)-9;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
