CLASS zcl_node DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_node.
    METHODS constructor
      IMPORTING
        value TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA chalk TYPE i.
    DATA previous TYPE REF TO zif_node.
    DATA next TYPE REF TO zif_node.
ENDCLASS.



CLASS zcl_node IMPLEMENTATION.


  METHOD constructor.
    me->chalk = value.
    me->next = NEW zcl_empty_node( ).
    me->previous = NEW zcl_empty_node( ).
  ENDMETHOD.


  METHOD zif_node~is_empty.
    return = abap_false.
  ENDMETHOD.


  METHOD zif_node~get_next_node.
    return = next.
  ENDMETHOD.


  METHOD zif_node~get_previous_node.
    return = previous.
  ENDMETHOD.


  METHOD zif_node~set_next.
    me->next = node.
  ENDMETHOD.


  METHOD zif_node~set_previous.
    me->previous = node.
  ENDMETHOD.


  METHOD zif_node~value.
    return = chalk.
  ENDMETHOD.
ENDCLASS.
