INTERFACE zif_node
  PUBLIC .
  METHODS set_next
    IMPORTING
      node TYPE REF TO zif_node.
  METHODS set_previous
    IMPORTING
      node TYPE REF TO zif_node.
  METHODS value
    RETURNING VALUE(return) TYPE i.
  METHODS get_next_node
    RETURNING VALUE(return) TYPE REF TO zif_node.
  METHODS get_previous_node
    RETURNING VALUE(return) TYPE REF TO zif_node.
  METHODS is_empty
    RETURNING VALUE(return) TYPE abap_bool.
ENDINTERFACE.