view: store_returns {
  sql_table_name: "DATA_DEV"."STORE_RETURNS"
    ;;

  dimension: sr_addr_sk {
    type: number
    sql: ${TABLE}."SR_ADDR_SK" ;;
  }

  dimension: sr_cdemo_sk {
    type: number
    sql: ${TABLE}."SR_CDEMO_SK" ;;
  }

  dimension: sr_customer_sk {
    type: number
    sql: ${TABLE}."SR_CUSTOMER_SK" ;;
  }

  dimension: sr_fee {
    type: number
    sql: ${TABLE}."SR_FEE" ;;
  }

  dimension: sr_hdemo_sk {
    type: number
    sql: ${TABLE}."SR_HDEMO_SK" ;;
  }

  dimension: sr_item_sk {
    type: number
    sql: ${TABLE}."SR_ITEM_SK" ;;
  }

  dimension: sr_net_loss {
    type: number
    sql: ${TABLE}."SR_NET_LOSS" ;;
  }

  dimension: sr_reason_sk {
    type: number
    sql: ${TABLE}."SR_REASON_SK" ;;
  }

  dimension: sr_refunded_cash {
    type: number
    sql: ${TABLE}."SR_REFUNDED_CASH" ;;
  }

  dimension: sr_return_amt {
    type: number
    sql: ${TABLE}."SR_RETURN_AMT" ;;
  }

  dimension: sr_return_amt_inc_tax {
    type: number
    sql: ${TABLE}."SR_RETURN_AMT_INC_TAX" ;;
  }

  dimension: sr_return_quantity {
    type: number
    sql: ${TABLE}."SR_RETURN_QUANTITY" ;;
  }

  dimension: sr_return_ship_cost {
    type: number
    sql: ${TABLE}."SR_RETURN_SHIP_COST" ;;
  }

  dimension: sr_return_tax {
    type: number
    sql: ${TABLE}."SR_RETURN_TAX" ;;
  }

  dimension: sr_return_time_sk {
    type: number
    sql: ${TABLE}."SR_RETURN_TIME_SK" ;;
  }

  dimension: sr_returned_date_sk {
    type: number
    sql: ${TABLE}."SR_RETURNED_DATE_SK" ;;
  }

  dimension: sr_reversed_charge {
    type: number
    sql: ${TABLE}."SR_REVERSED_CHARGE" ;;
  }

  dimension: sr_store_credit {
    type: number
    sql: ${TABLE}."SR_STORE_CREDIT" ;;
  }

  dimension: sr_store_sk {
    type: number
    sql: ${TABLE}."SR_STORE_SK" ;;
  }

  dimension: sr_ticket_number {
    type: number
    sql: ${TABLE}."SR_TICKET_NUMBER" ;;
  }

  dimension: is_less30{
    type: yesno
    sql:
      ${date_dim.d_date} >= to_date('2002-01-01','YYYY-MM-DD')
      and
      ${date_dim.d_date} <= to_date('2002-01-01','YYYY-MM-DD') + 30 ;;
  }
  measure: 30Days {
    type:sum
    sql: ${sr_return_quantity} ;;
    filters: {
      field: is_less30
      value: "yes"
    }
  }

  dimension: is_less60{
    type: yesno
    sql:
      ${date_dim.d_date} >= to_date('2002-01-01','YYYY-MM-DD')
      and
      ${date_dim.d_date} <= to_date('2002-01-01','YYYY-MM-DD') + 60 ;;
  }
  measure: 60Days {
    type:sum
    sql: ${sr_return_quantity} ;;
    filters: {
      field: is_less60
      value: "yes"
    }
  }

  dimension: is_less90{
    type: yesno
    sql:
      ${date_dim.d_date} >= to_date('2002-01-01','YYYY-MM-DD')
      and
      ${date_dim.d_date} <= to_date('2002-01-01','YYYY-MM-DD') + 90 ;;
  }
  measure: 90Days {
    type:sum
    sql: ${sr_return_quantity} ;;
    filters: {
      field: is_less90
      value: "yes"
    }
  }

  dimension: is_above90{
    type: yesno
    sql:
      ${date_dim.d_date} >= to_date('2002-01-01','YYYY-MM-DD') + 91
      and
      ${date_dim.d_date} <= to_date('2002-01-01','YYYY-MM-DD') + 364 ;;
  }
  measure: after90Days {
    type:sum
    sql: ${sr_return_quantity} ;;
    filters: {
      field: is_above90
      value: "yes"
    }
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
