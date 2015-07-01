CLASS lct_doubly_linked_list DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    DATA doubly_linked_list TYPE REF TO zcl_doubly_linked_list.
    METHODS:
      setup,

      insert_beginning_when_empty FOR TESTING,
      insert_end_when_empty       FOR TESTING,
      insert_beginning_then_end   FOR TESTING,
      insert_beginning_then_after FOR TESTING,
      insert_beg_end_after        FOR TESTING,
      insert_beg_after_end        FOR TESTING,
      initially_list_is_empty     FOR TESTING,
      insert_beg_before           FOR TESTING,
      beginning_before_after      FOR TESTING,
      beginning_remove            FOR TESTING,
      beginning_after_remove      FOR TESTING,
      beginning_end_remove        FOR TESTING,
      acceptance_test             FOR TESTING.

ENDCLASS.

CLASS lct_doubly_linked_list IMPLEMENTATION.
  METHOD setup.
    me->doubly_linked_list = NEW zcl_doubly_linked_list( ).
  ENDMETHOD.



  METHOD insert_beginning_when_empty.
    DATA(node) = NEW zcl_node( 3 ).
    me->doubly_linked_list->insert_beginning( node ).

    DATA printable_list TYPE STANDARD TABLE OF i.
    printable_list = me->doubly_linked_list->get_printable_list( ).

    cl_abap_unit_assert=>assert_equals(
      act = printable_list[ 1 ]
      exp = 3
    ).
  ENDMETHOD.



  METHOD insert_end_when_empty.
    DATA(node) = NEW zcl_node( 4 ).
    me->doubly_linked_list->insert_end( node ).

    DATA printable_list TYPE STANDARD TABLE OF i.
    printable_list = me->doubly_linked_list->get_printable_list( ).

    cl_abap_unit_assert=>assert_equals(
      act = printable_list[ 1 ]
      exp = 4
    ).
  ENDMETHOD.

  METHOD insert_beginning_then_end.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA last_node TYPE REF TO zif_node.
    last_node = NEW zcl_node( 9 ).
    me->doubly_linked_list->insert_end( last_node ).

    cl_abap_unit_assert=>assert_equals(
     act = first_node->get_next_node( )
     exp = last_node
   ).

    cl_abap_unit_assert=>assert_equals(
      act = last_node->get_previous_node( )
      exp = first_node
    ).
  ENDMETHOD.

  METHOD insert_beginning_then_after.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA second_node TYPE REF TO zif_node.
    second_node = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_after(
      previous_node = first_node
      new_node      = second_node
    ).

    cl_abap_unit_assert=>assert_equals(
     act = first_node->get_next_node( )
     exp = second_node
   ).

    cl_abap_unit_assert=>assert_equals(
      act = second_node->get_previous_node( )
      exp = first_node
    ).

  ENDMETHOD.
  METHOD insert_beg_end_after.
    DATA(node_1) = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( node_1 ).

    DATA(node_3) = NEW zcl_node( 3 ).
    me->doubly_linked_list->insert_end( node_3 ).

    DATA(node_2) = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_after(
      previous_node = node_1
      new_node      = node_2
    ).

    DATA(lt_printable_list) =  me->doubly_linked_list->get_printable_list( ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 1 ]
      exp = 1
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 2 ]
      exp = 2
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 3 ]
      exp = 3
    ).
  ENDMETHOD.



  METHOD insert_beg_after_end.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA second_node TYPE REF TO zif_node.
    second_node = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_after(
      previous_node = first_node
      new_node      = second_node
    ).

    cl_abap_unit_assert=>assert_equals(
     act = first_node->get_next_node( )
     exp = second_node
   ).

    cl_abap_unit_assert=>assert_equals(
      act = second_node->get_previous_node( )
      exp = first_node
    ).

    DATA third_node TYPE REF TO zif_node.
    third_node = NEW zcl_node( 3 ).
    me->doubly_linked_list->insert_end( third_node ).

    cl_abap_unit_assert=>assert_equals(
     act = second_node->get_next_node( )
     exp = third_node
   ).

    cl_abap_unit_assert=>assert_equals(
      act = third_node->get_previous_node( )
      exp = second_node
    ).
  ENDMETHOD.

  METHOD initially_list_is_empty.
    cl_abap_unit_assert=>assert_initial( me->doubly_linked_list->get_printable_list( ) ).
  ENDMETHOD.

  METHOD insert_beg_before.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA second_node TYPE REF TO zif_node.
    second_node = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_before(
      previous_node = first_node
      new_node      = second_node
    ).

    cl_abap_unit_assert=>assert_equals(
     act = second_node->get_next_node( )
     exp = first_node
   ).

    cl_abap_unit_assert=>assert_equals(
      act = first_node->get_previous_node( )
      exp = second_node
    ).
  ENDMETHOD.
  METHOD beginning_before_after.

    DATA node_2 TYPE REF TO zif_node.
    node_2 = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_beginning( node_2 ).

    DATA node_1 TYPE REF TO zif_node.
    node_1 = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_before(
      previous_node = node_2
      new_node      = node_1
    ).

    DATA node_3 TYPE REF TO zif_node.
    node_3 = NEW zcl_node( 3 ).
    me->doubly_linked_list->insert_after(
      previous_node = node_2
      new_node      = node_3
    ).

    DATA(lt_printable_list) =  me->doubly_linked_list->get_printable_list( ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 1 ]
      exp = 1
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 2 ]
      exp = 2
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 3 ]
      exp = 3
    ).
  ENDMETHOD.

  METHOD beginning_remove.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    doubly_linked_list->remove( first_node ).

    cl_abap_unit_assert=>assert_initial( me->doubly_linked_list->get_printable_list( ) ).
  ENDMETHOD.

  METHOD beginning_after_remove.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA second_node TYPE REF TO zif_node.
    second_node = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_after(
      previous_node = first_node
      new_node      = second_node
    ).

    me->doubly_linked_list->remove( second_node ).

    DATA(lt_printable_list) =  me->doubly_linked_list->get_printable_list( ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 1 ]
      exp = 1
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_printable_list )
      exp = 1
    ).
  ENDMETHOD.


  METHOD beginning_end_remove.
    DATA first_node TYPE REF TO zif_node.
    first_node = NEW zcl_node( 1 ).
    me->doubly_linked_list->insert_beginning( first_node ).

    DATA second_node TYPE REF TO zif_node.
    second_node = NEW zcl_node( 2 ).
    me->doubly_linked_list->insert_end( new_node = second_node ).

    me->doubly_linked_list->remove( second_node ).

    DATA(lt_printable_list) =  me->doubly_linked_list->get_printable_list( ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 1 ]
      exp = 1
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_printable_list )
      exp = 1
    ).
  ENDMETHOD.

  METHOD acceptance_test.
    "7 (begin 7)
    "7, 8 (8 at end)
    "7, 9, 8 (9 after 7)
    "7, 8 (remove 9)
    "6, 9, 8 (begin 6)

    DATA(node_7) = NEW zcl_node( 7 ).
    me->doubly_linked_list->insert_beginning( node_7 ).

    DATA(node_8) = NEW zcl_node( 8 ).
    me->doubly_linked_list->insert_end( node_8 ).

    DATA(node_9) = NEW zcl_node( 9 ).
    me->doubly_linked_list->insert_after(
      previous_node = node_7
      new_node      = node_9
    ).
   me->doubly_linked_list->remove( node_9 ).

    DATA(node_6) = NEW zcl_node( 6 ).
    me->doubly_linked_list->insert_beginning( node_6 ).

    DATA(lt_printable_list) =  me->doubly_linked_list->get_printable_list( ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 1 ]
      exp = 6
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 2 ]
      exp = 7
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_printable_list[ 3 ]
      exp = 8
    ).
  ENDMETHOD.


ENDCLASS.