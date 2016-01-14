var UptimeTick = React.createClass({
  propTypes: {
    label: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <div className="uptime-tick">
        {this.props.label}
      </div>
    );
  }
});
