var UptimeBlock = React.createClass({
  propTypes: {
    data: React.PropTypes.array.isRequired
  },

  render: function() {
    var uptimeNodes = this.props.data.map(function(item) {
      if (item.duration > 7200) {
        item.status = "critical";
      } else if (item.duration > 0) {
        item.status = "warning";
      } else {
        item.status = "ok";
      }

      return (
        <Uptime {...item} key={Math.random()} />
      )
    });
    return (
      <div className="uptime-block">
        {uptimeNodes}
      </div>
    );
  }
});
