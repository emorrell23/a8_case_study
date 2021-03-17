view: dt_total_sales_by_order {
  derived_table: {
    explore_source: order_items {
      column: total_gross_revenue {}
      column: order_id {}
    }
    datagroup_trigger: case_studies_default_datagroup
  }

  dimension: total_gross_revenue {
    label: "Total Sales By Order"
    value_format: "$#,##0.00"
    type: number
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
    primary_key: yes
    type: number
  }
}
