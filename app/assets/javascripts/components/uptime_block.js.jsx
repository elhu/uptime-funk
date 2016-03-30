var UptimeBlock = React.createClass({
  propTypes: {
    data: React.PropTypes.array.isRequired
  },

  render: function() {
    var uptimeTickNodes = this.props.data.map(function(item) {
      if (item.duration > 7200) {
        item.status = "critical";
      } else if (item.duration > 0) {
        item.status = "warning";
      } else {
        item.status = "ok";
      }

      return (
        <UptimeTick {...item} key={Math.random()} />
      )
    });
    return (
      <div className="uptime-block">
        {uptimeTickNodes}
      </div>
    );
  }
});
