find_package (Threads)

add_executable(clickhouse-odbc-ut
    main.cpp
    escape_sequences_ut.cpp
    lexer_ut.cpp
)

target_link_libraries(clickhouse-odbc-ut
    clickhouse-odbc-escaping
    gtest-lib
    Threads::Threads
)

add_test(NAME "clickhouse-odbc-ut" COMMAND "clickhouse-odbc-ut")

if (NANOODBC_LIBRARY)
    add_executable(clickhouse-odbc-nano nano.cpp)
    target_link_libraries(clickhouse-odbc-nano ${NANOODBC_LIBRARY})
    add_dependencies(clickhouse-odbc-nano clickhouse-odbc)
    if (TEST_DSN)
        add_test(NAME "clickhouse-odbc-nano" COMMAND clickhouse-odbc-nano DSN=${TEST_DSN})
        if (NOT (CMAKE_BUILD_TYPE_UC STREQUAL "TSAN" OR CMAKE_BUILD_TYPE_UC STREQUAL "ASAN" OR CMAKE_BUILD_TYPE_UC STREQUAL "MSAN"))
            add_test(NAME "clickhouse-odbc-nano-valgrind" COMMAND valgrind -v --leak-check=full --show-leak-kinds=all ${CMAKE_CURRENT_BINARY_DIR}/clickhouse-odbc-nano DSN=${TEST_DSN})
        endif ()
    endif ()
    # gdb -ex "catch throw" -ex run --args ./clickhouse-odbc-nano DSN=clickhouse_localhost_system
endif ()
