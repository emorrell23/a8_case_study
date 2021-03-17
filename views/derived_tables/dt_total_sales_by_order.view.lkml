view: dt_total_sales_by_order {
  derived_table: {
    explore_source: order_items {
      column: total_sales {}
      column: order_id {}
    }
    datagroup_trigger: case_studies_default_datagroup
  }

  dimension: total_sales {
    label: "Total Sales By Order"
    value_format: "$#,##0.00"
    type: number
  }

  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
  }
}
