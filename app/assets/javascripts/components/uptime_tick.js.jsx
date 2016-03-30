var UptimeTick = React.createClass({
  propTypes: {
    status: React.PropTypes.string.isRequired,
    date: React.PropTypes.number.isRequired
  },

  // days: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
  days: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],

  render: function() {
    var date = new Date();
    date.setTime(this.props.date * 1000);
    var classes = ["uptime", this.props.status, this.days[date.getDay()].toLowerCase()];
    return (
      <div className={classes.join(" ")}>
        <div className="day">
          {this.days[date.getDay()][0]}
        </div>
      </div>
    );
  }
});
