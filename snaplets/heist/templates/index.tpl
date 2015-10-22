<apply template="base">
  <div class="page-header">
    <h1>TODOS</h1>
  </div>

  <div id="todo-list"></div>

  <script>
    var TodoEntry = React.createClass({
      getInitialState: function() {
        return { editMode: false }
      },

      enableEditMode: function() {
        this.setState({ editMode: true });
      },

      disableEditMode: function() {
        this.setState({ editMode: false });
      },

      render: function() {
        if (this.state.editMode) {
          return React.createElement('li', null, React.createElement('input', {
            autoFocus: true,
            onBlur:    this.disableEditMode,
            value:     this.props.data.text
          }));
        } else {
          return React.createElement('li', { onClick: this.enableEditMode }, this.props.data.text);
        }
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
