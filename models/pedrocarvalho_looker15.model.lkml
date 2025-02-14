connection: "tpchlooker"

# include all the views
# include: "/views/**/*.view.lkml"
include: "/views/f_lineitems.view.lkml"
include: "/views/d_part.view.lkml"
include: "/views/d_supplier.view.lkml"
include: "/views/d_customer.view.lkml"

datagroup: pedrocarvalho_looker15_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: pedrocarvalho_looker15_default_datagroup

# explore: d_customer {}

# explore: d_dates {}

# explore: d_part {}

explore: d_supplier {}

explore: f_lineitems {

  join: d_part {
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
  }
  join: d_supplier {
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
  }
  join: d_customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey} ;;
  }
}
