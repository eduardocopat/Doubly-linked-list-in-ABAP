CLASS zcl_empty_node DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
  interfaces zif_node.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EMPTY_NODE IMPLEMENTATION.


  METHOD zif_node~get_next_node.

  ENDMETHOD.


  METHOD zif_node~get_previous_node.

  ENDMETHOD.


  METHOD zif_node~is_empty.
    return = abap_true.
  ENDMETHOD.


  METHOD zif_node~set_next.

  ENDMETHOD.


  METHOD zif_node~set_previous.

  ENDMETHOD.


  METHOD zif_node~value.

  ENDMETHOD.
ENDCLASS.