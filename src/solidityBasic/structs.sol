//SPXD-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }
    

    Todo[] public todos;
    function creat(string calldata _text) public {

        todos.push(Todo(_text, false));
        todos.push(Todo({text: _text, completed: false}));
        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
    }

    function get(uint index) 
    public 
    view 
    returns(string memory text, bool completed) {
        Todo memory todo;
        return (todo.text, todo.completed);
    }

    function updatetext(uint index, string calldata _text) public {
        Todo storage todo = todos[index];
        todo.text = _text;
    }

    function toggleCompleted(uint index) public {
        Todo storage todo = todos[index];
        todo.completed = !todo.completed;
    }
}