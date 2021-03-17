view: dt_total_sales_by_order {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: number_of_items {}
      column: total_gross_revenue {}
    }
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
    primary_key: yes
    type: number
  }

  dimension: number_of_items {
    hidden: yes
    label: "Per Order | Number of Items"
  }

  dimension: has_more_than_one_item_in_order {
    type: yesno
    sql: ${number_of_items} > 1 ;;
  }

  dimension: total_gross_revenue {
    hidden: yes
    label: "Per Order | Total Gross Revenue"
    value_format: "$#,##0.00"
    type: number
  }

  measure: per_order_average_gross_revenue {
    label: "Per Order | Average Gross Revenue"
    type: average
    value_format_name: usd
    sql: ${total_gross_revenue} ;;
    filters: [order_items.status: "-Returned,-Cancelled"]
  }

  measure: per_order_average_number_of_items {
    label: "Per Order | Average Number of Items"
    type: average
    sql: ${number_of_items} ;;
    filters: [order_items.status: "-Returned,-Cancelled"]
  }
}
