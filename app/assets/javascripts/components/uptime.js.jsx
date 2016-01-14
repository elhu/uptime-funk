var Uptime = React.createClass({
  propTypes: {
    status: React.PropTypes.string.isRequired,
    date: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <div className={"uptime " + this.props.status}>
        <div className="uptime-tick-border" />
        <UptimeTick label={this.props.date} />
      </div>
    );
  }
});
