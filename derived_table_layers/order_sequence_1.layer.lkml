include: "/_layers/_base.layer"

# Adding a new measure to order_items
view: +order_items {
  measure: order_sequence {
    description: "
    Shows the sequence that orders occurred per user,
    used for creating flags for whether an order is a users' first, whether
    a user is a return customer, etc.
    "
    type: number
    sql: ROW_NUMBER() OVER(PARTITION BY ${user_id} ORDER BY ${created_date}) ;;
  }
}

# Create a new derived table using this measure
view: order_sequence_1 {
  derived_table: {
    explore_source: order_items {
      column: order_sequence {}
      column: user_id {}
      column: order_id {}
      column: created_date {}
    }
    datagroup_trigger: case_studies_default_datagroup
  }
  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
  }
  dimension: created_date {
    hidden: yes
    type: date
  }
  dimension: order_sequence {
    hidden: yes
    description: "
    Shows the sequence that orders occurred per user,
    used for creating flags for whether an order is a users' first, whether
    a user is a return customer, etc.
    "
    type: number
  }
  dimension: user_id {
    label: "derived_user_id"
    hidden: yes
    type: number
  }
}

# Creating a hidden explore used to generate the next derived table
explore: order_sequence_1 {hidden: yes}