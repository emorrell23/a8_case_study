view: dt_total_sales_by_order {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: number_of_items {}
      column: total_gross_revenue {}
    }
    datagroup_trigger: case_studies_default_datagroup
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
    primary_key: yes
    type: number
  }

  dimension: number_of_items {
    label: "Per Order | Number of Items"
  }

  dimension: total_gross_revenue {
    label: "Per Order | Total Gross Revenue"
    value_format: "$#,##0.00"
    type: number
  }
}
