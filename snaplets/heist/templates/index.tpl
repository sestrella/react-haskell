<apply template="base">
  <div class="page-header">
    <h1>TODOS</h1>
  </div>

  <div id="todo-app"></div>

  <script type="text/babel">
    //var LinkedStateMixin = React.addons.LinkedStateMixin;

    var TodoForm = React.createClass({
      //mixins: [LinkedStateMixin],

      getInitialState: function() {
        return { value: '' };
      },

      render: function() {
        return (
          <input onKeyDown={this.onKeyDown}
                 onChange={this.onChange}
                 className='form-control'
                 placeholder='Pending task'
                 value={this.state.value} />
                 //valueLink={this.linkState('value')} />
        );
      },

      onChange: function(event) {
        this.setState({ value: event.target.value });
      },

      onKeyDown: function(event) {
        if (event.keyCode === 13) {
          this.props.onSave(this.state.value);
          this.setState({ value: '' });
        }
      }
    });

    var TodoEntry = React.createClass({
      getInitialState: function() {
        return { displayButton: false };
      },

      render: function() {
        return (
          <li id={this.props.todo.id}
              className='todo'
              onMouseEnter={this.displayButton}
              onMouseLeave={this.hideButton}>
            <span className='description'>{this.props.todo.description}</span>
            {this.button()}
          </li>
        );
      },

      displayButton: function() {
        this.setState({ displayButton: true });
      },

      hideButton: function() {
        this.setState({ displayButton: false });
      },

      button: function() {
        if (this.state.displayButton) {
          return (
            <button onClick={this.destroy} className="btn tn-default btn-xs">
              <span className="glyphicon glyphicon-remove" aria-hidden="true"></span>
            </button>
          );
        }
        return '';
      },

      destroy: function() {
        this.props.onDestroy(this.props.todo.id);
      }
    });

    var TodoList = React.createClass({
      render: function() {
        var todos = this.props.todos.map((todo) => {
          return (
            <TodoEntry todo={todo} onDestroy={this.props.onDestroy} />
          );
        });
        return (<ul id='todo-list' className='list-unstyled'>{todos}</ul>);
      }
    });

    var TodoApp = React.createClass({
      getInitialState: function() {
        return { todos: [] };
      },

      componentDidMount: function() {
        $.ajax({
          url: 'api/todos',
          success: (todos) => {
            this.setState({ todos: todos });
          }
        });
      },

      render: function() {
        return (
          <div>
            <TodoForm onSave={this.save} />
            <TodoList todos={this.state.todos} onDestroy={this.destroy} />
          </div>
        );
      },

      save: function(description) {
        $.ajax({
          url: 'api/todos',
          method: 'post',
          data: JSON.stringify({ id: 0, description: description }),
          success: (todos) => {
            this.setState({ todos: todos });
          },
          error: () => {
            this.setState({ todos: [] });
          }
        });
      },

      destroy: function(id) {
        $.ajax({
          url: `api/todo/${id}`,
          method: 'delete',
          success: (todos) => {
            this.setState({ todos: todos });
          },
          error: () => {
            this.setState({ todos: [] });
          }
        });
      }
    });

    ReactDOM.render(
      <TodoApp />,
      document.getElementById('todo-app')
    );
  </script>
</apply>
