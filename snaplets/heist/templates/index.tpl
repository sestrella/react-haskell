<apply template="base">
  <div class="page-header">
    <h1>TODOS</h1>
  </div>

  <div id="todo-list"></div>

  <script>
    var TodoEntry = React.createClass({
      render: function() {
        return React.createElement('li', null, this.props.data.text);
      }
    });

    var TodoList = React.createClass({
      getInitialState: function() {
        return { data: [] };
      },

      componentDidMount: function() {
        $.ajax({
          url: this.props.url,
          success: function(data) {
            this.setState({ data: data });
          }.bind(this)
        });
      },

      render: function() {
        var todos = this.state.data.map(function(todo) {
          return React.createElement(TodoEntry, { data: todo });
        });
        return React.createElement('ul', null, todos);
      }
    });

    ReactDOM.render(
      React.createElement(TodoList, { url: 'api/todos' }),
      document.getElementById('todo-list')
    );
  </script>
</apply>
