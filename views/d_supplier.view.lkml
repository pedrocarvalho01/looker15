view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER" ;;

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }
  dimension: s_acctbal_tier {
    type: tier
    tiers: [1, 3001, 5001, 7001]
    sql: ${s_acctbal} ;;
    style: integer
    description: "Tier created to be used within a Cohort of Suppliers according to Account Balance"
  }
  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }
  dimension: s_name {
    type: string
    sql: ${TABLE}."S_NAME" ;;
    link: {
      label: "Search on Google for {{ value }}"
      url: "https://www.google.com/search?q={{ value | url_encode }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "See Revenue Details"
      url: "/looks/539?&f[d_supplier.s_name]={{ value | url_encode }}"
    }
  }
  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }
  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }
  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }
  dimension: s_suppkey {
    primary_key: yes
    type: number
    sql: ${TABLE}."S_SUPPKEY" ;;
  }
  measure: count {
    label: "Supplier Count"
    type: count
    drill_fields: [s_name]
  }
  measure: account_balance {
    type: sum
    sql: ${s_acctbal} ;;
    # value_format_name: usd_0
    description: "Sum of Account Balance"
  }
}
