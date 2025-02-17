view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS" ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }
  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }
  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }
  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }
  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }
  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }
  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }
  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }
  dimension: l_orderkey {
    primary_key: yes
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }
  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }
  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }
  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }
  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }
  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }
  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }
  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }
  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }
  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }
  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }
  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }
  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }
  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }
  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }
  measure: count {
    label: "Line Items Count"
    type: count
  }
  measure: total_sale_price {
    type: sum
    sql: ${l_totalprice} ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    description: "Total Sales from Items sold, is Sum of Total Price"
  }
  measure: avg_sale_price {
    type: average
    sql: ${l_totalprice} ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    description: "Average Price from Items sold, is Avg of Total Price"
  }
  measure: cumulative_total {
    type: running_total
    sql: ${total_sale_price} ;;
    value_format_name: usd_0
    description: "Cumulative of Total Sales from Items sold, is Running Total of Total Price"
  }
  measure: total_gross_revenue {
    type: sum
    sql: ${l_totalprice} ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    filters: [l_orderstatus: "F"]
    description: "Total Price of Completed Sales, is Sum of Total Price filtering Order Status equals F "
  }
  measure: total_cost {
    type: sum
    sql: ${l_supplycost} ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    description: "Total Cost is Sum of Supply Cost"
  }
  measure: total_gross_margin {
    type: number
    sql: ${total_gross_revenue} - ${total_cost} ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    # value_format_name: usd_0
    description: "Total Gross Margin is Total Gross Revenue minus Total Cost"
  }
  measure: gross_margin_percentage {
    type: number
    sql: ${total_gross_margin}/ NULLIF(${total_gross_revenue},0) ;;
    value_format_name: percent_2
    description: "Gross Margin Percentage is Total Gross Margin divided by Total Gross Revenue"
  }
  measure: items_returned {
    type: count
    filters: [l_returnflag: "R"]
    description: "Number of Liten Order Items that were returned by dissatisfied customers, Return Flag equal R"
  }
  measure: items_sold {
    type: count
    filters: [l_orderstatus: "F"]
    description: "Number of Liten Order Items sold, Order Status equals F"
  }
  measure: item_return_rate {
    type: number
    sql: ${items_returned} / NULLIF(${items_sold},0) ;;
    value_format_name: percent_2
    description: "Item Return Rate is total of Items Returned divided by total of Items Sold"
  }
  measure: count_customer {
    type: count_distinct
    sql: ${l_custkey} ;;
  }
  measure: average_spend_customer {
    type: number
    sql: ${total_sale_price} / NULLIF(${count_customer},0) ;;
    value_format: "[>=1000000]$#,##0,,\"M\";$#,##0"
    description: "Average Spend per Customer is Total Sale Price divided by Total number of Customers"
  }
}
