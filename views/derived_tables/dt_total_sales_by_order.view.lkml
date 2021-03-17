view: dt_total_sales_by_order {
  derived_table: {
    explore_source: order_items {
      column: total_sales {}
      column: order_id {}
    }
  }
  dimension: total_sales_by_order {
    value_format: "$#,##0.00"
    type: number
  }
  dimension: order_id {
    type: number
  }
}
