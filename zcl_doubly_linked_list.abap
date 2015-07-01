CLASS zcl_doubly_linked_list DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS insert_beginning
      IMPORTING
        new_node TYPE REF TO zif_node.
    METHODS get_printable_list
      RETURNING
        VALUE(return) TYPE crmt_bsp_int_tab.
    METHODS insert_end
      IMPORTING
        new_node TYPE REF TO zif_node.
    METHODS insert_after
      IMPORTING
        previous_node TYPE REF TO zif_node
        new_node      TYPE REF TO zif_node.
    METHODS insert_before
      IMPORTING
        previous_node TYPE REF TO zif_node
        new_node      TYPE REF TO zif_node.
    METHODS remove
      IMPORTING
        node_to_remove TYPE REF TO zif_node.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA first_node TYPE REF TO zif_node.
    METHODS read_last_node
      RETURNING
        VALUE(rv_last_node) TYPE REF TO zif_node.
    METHODS list_is_empty
      RETURNING
        VALUE(rv_return) TYPE abap_bool.
ENDCLASS.



CLASS zcl_doubly_linked_list IMPLEMENTATION.


  METHOD constructor.
    first_node = NEW zcl_empty_node( ).
    first_node->set_next( NEW zcl_empty_node( ) ).
    first_node->set_previous( NEW zcl_empty_node( ) ).
  ENDMETHOD.


  METHOD get_printable_list.
    DATA(list_node) = first_node.
    WHILE list_node->is_empty( ) = abap_false.
      APPEND list_node->value( ) TO return.
      list_node = list_node->get_next_node( ).
    ENDWHILE.
  ENDMETHOD.


  METHOD insert_after.
    DATA(old_next) = previous_node->get_next_node( ).
    previous_node->set_next( new_node ).
    new_node->set_previous( previous_node ).
    new_node->set_next( old_next ).
  ENDMETHOD.


  METHOD insert_beginning.
    new_node->set_next( first_node ).
    first_node = new_node.
  ENDMETHOD.


  METHOD insert_end.
    IF list_is_empty( ).
      insert_beginning( new_node ).
      RETURN.
    ENDIF.

    DATA(current_last_node) = read_last_node( ).

    current_last_node->set_next( new_node ).
    new_node->set_previous( current_last_node ).
  ENDMETHOD.

  METHOD insert_before.
    IF previous_node = first_node.
      DATA(before_first_node) = abap_true.
    ENDIF.

    "Inserting before is inserting after the request node previous node!
    insert_after(
      previous_node = new_node
      new_node      = previous_node
    ).

    IF before_first_node = abap_true.
      first_node = new_node.
    ENDIF.
  ENDMETHOD.


  METHOD read_last_node.
    rv_last_node  = first_node.
    WHILE rv_last_node->get_next_node( )->is_empty( ) = abap_false.
      rv_last_node = rv_last_node->get_next_node( ).
    ENDWHILE.
  ENDMETHOD.


  METHOD list_is_empty.
    rv_return = first_node->is_empty( ).
  ENDMETHOD.


  METHOD remove.
    DATA(removed_node_previous) = node_to_remove->get_previous_node( ).
    DATA(removed_node_next) = node_to_remove->get_next_node( ).

    removed_node_previous->set_next( removed_node_next ).
    removed_node_next->set_previous( removed_node_previous ).

    IF node_to_remove = first_node.
      first_node = removed_node_previous.
    ENDIF.
  ENDMETHOD.

ENDCLASS.