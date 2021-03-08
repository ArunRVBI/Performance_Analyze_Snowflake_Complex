view: store_sales {
  sql_table_name: "DATA"."STORE_SALES"
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

#custom dimension
  measure: ss_customer_sk_distinct {
    type: count_distinct
    sql: ${TABLE}."SS_CUSTOMER_SK" ;;
  }

  dimension: is_ytd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})
      and
      ${date_dim.d_date} <= {% parameter date_dim.datefilter %}
      ;;
  }
  dimension: is_mtd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      and
      ${date_dim.d_date} <= {% parameter date_dim.datefilter %}
      ;;
  }
  dimension: is_sply_ytd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})-1
      and
      ${date_dim.d_date}<= TO_DATE({% parameter date_dim.datefilter %})-365
      ;;
  }
  dimension: is_sply_mtd{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})-1
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      and
      ${date_dim.d_date} <= TO_DATE({% parameter date_dim.datefilter %})-365
      ;;
  }

  measure: ytd_CustCount {
    type:count_distinct
    sql: ${ss_customer_sk} ;;
    filters: {
      field: is_ytd
      value: "yes"
    }
  }
  measure: mtd_CustCount {
    type:count_distinct
    sql: ${ss_customer_sk} ;;
    filters: {
      field: is_mtd
      value: "yes"
    }
  }
  measure: sply_ytd_CustCount {
    type:count_distinct
    sql: ${ss_customer_sk} ;;
    filters: {
      field: is_sply_ytd
      value: "yes"
    }
  }
  measure: sply_mtd_CustCount {
    type:count_distinct
    sql: ${ss_customer_sk} ;;
    filters: {
      field: is_sply_mtd
      value: "yes"
    }
  }
  measure: ss_sales_price_ytd {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE" ;;
    filters: [is_ytd: "yes"]
  }
  measure: ss_sales_price_mtd {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE" ;;
    filters: [is_mtd: "yes"]
  }
  measure: ss_sales_price_sply_ytd {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE" ;;
    filters: [is_sply_ytd: "yes"]
  }
  measure: ss_sales_price_sply_mtd {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE" ;;
    filters: [is_sply_mtd: "yes"]
  }

  dimension: currentYear{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      ;;
  }
  dimension: previousYear{
    type: yesno
    sql:
      ${date_dim.d_year} = year({% parameter date_dim.datefilter %})-1
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      ;;
  }
  measure: currentyear_sales {
    type: sum
    sql:  ${TABLE}."SS_SALES_PRICE";;
    filters: [currentYear: "yes"]
  }
  measure: previousyear_sales {
    type: sum
    sql:  ${TABLE}."SS_SALES_PRICE";;
    filters: [previousYear: "yes"]
  }
  measure: sales_ratio {
    type: number
    sql: (${currentyear_sales}-${previousyear_sales})/${previousyear_sales} * 100 ;;
    value_format: "0.00"
  }
  dimension: Weekcount {
    type: number
    sql: WEEKOFYEAR(to_date(${date_dim.d_date})) ;;
  }
  dimension: Weekday {
    type: number
    sql: DAYOFWEEK(to_date(${date_dim.d_date})) ;;
  }
  dimension: weekdays {
    type: string
    sql: CASE
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 0 THEN 'Sunday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 1 THEN 'Monday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 2 THEN 'Tuesday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 3 THEN 'Wednesday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 4 THEN 'Thursday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 5 THEN 'Friday'
        WHEN DAYOFWEEK(to_date(${date_dim.d_date})) = 6 THEN 'saturday'
        ELSE 'null'
        END ;;
  }
  dimension: ss_issalesPriceTop10 {
    type: yesno
    sql: ${date_dim.d_month} = substring({% parameter date_dim.datefilter %},1,7);;
  }
  measure: ss_salesprice {
    type: sum
    sql: ${TABLE}."SS_SALES_PRICE";;
    filters: [ss_issalesPriceTop10: "yes"]
    value_format: "0"
  }

#For Charts
  dimension: dateflag{
    type: yesno
    sql:
     ( ${date_dim.d_year} = year({% parameter date_dim.datefilter %})
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      and
      ${date_dim.d_date} <= {% parameter date_dim.datefilter %}
      )
      or
      ( ${date_dim.d_year} = year({% parameter date_dim.datefilter %})-1
      and
      substring(${date_dim.d_month},6,2) = month({% parameter date_dim.datefilter %})
      and
      ${date_dim.d_date} <= TO_DATE({% parameter date_dim.datefilter %})-365
      )
      ;;
  }


  measure: currentyear_salesprice {
    type: sum
    sql:  ${TABLE}."SS_SALES_PRICE";;
    filters: [is_mtd: "yes"]
  }
  measure: previousyear_salesprice {
    type: sum
    sql:  ${TABLE}."SS_SALES_PRICE";;
    filters: [is_sply_mtd: "yes"]
  }
  measure: currentyear_listprice {
    type: sum
    sql:  ${TABLE}."SS_LIST_PRICE";;
    filters: [is_mtd: "yes"]
  }
  measure: previousyear_listprice {
    type: sum
    sql:  ${TABLE}."SS_LIST_PRICE";;
    filters: [is_sply_mtd: "yes"]
  }
  measure: currentyear_wholesalecost {
    type: sum
    sql:  ${TABLE}."SS_WHOLESALE_COST";;
    filters: [is_mtd: "yes"]
  }
  measure: previousyear_wholesalecost {
    type: sum
    sql:  ${TABLE}."SS_WHOLESALE_COST";;
    filters: [is_sply_mtd: "yes"]
  }
  measure: filter_dateflag {
    type: sum
    sql:  1;;
    filters: [dateflag: "yes"]
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
