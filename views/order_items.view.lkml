view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "IDs"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    group_label: "IDs"
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    group_label: "IDs"
    hidden: yes
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    description: "Sale price per item, hidden from end users but used in other measures"
    hidden: yes
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension: sale_price_tiers {
    description: "Breaks sales price up into different tiers to analyze the distribution of sale price"
    type: tier
    tiers: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    sql: ${sale_price} ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    group_label: "IDs"
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  ###################################
  #            MEASURES             #
  ###################################

  measure: number_of_items {
    type: count
    drill_fields: [detail*]
  }

  measure: number_of_orders {
    type: count_distinct
    sql: ${order_id} ;;
    drill_fields: [detail*]
  }

  measure: total_gross_revenue {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    filters: [status: "-Returned, -Cancelled"]
    drill_fields: [detail*]
  }

  measure: average_gross_revenue {}

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.first_name,
      users.id
    ]
  }

  # ---- Sets of fields for aggregate tables -----
  set: sales_calculations {
    fields: [
      total_gross_revenue
    ]
  }
}
