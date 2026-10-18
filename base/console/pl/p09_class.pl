# ****************************************************************************
$PGMNAME="[09]:Klassen";
# *****************************************************************************
# call: DOS/LINUX> perl File.pl
# uses: p00.pm
# Vers: PERL 5.0
# *****************************************************************************

# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;
$iEc  = $ENV{v_FWK_exitCode} + 0;

# ---- INHALT:
#   1) Klassen
#   2) SubKlassen
# *****************************************************************************
# goto l;

# ============================================================================
# 1) Klassen
# ============================================================================
# l:
# &dbg_TRACE("1) Klassen",__FILE__,__LINE__);

package P_BaseClass;                # Class nameSpace
# ---   no we are in the package 'P_BaseClass'

# use     strict;

# --- Konstruktor
sub newClassObj
{
	my $class = shift;
	my      $self = { };
	bless   $self;
	$self->{"name"} = "";
	$self->{"id"} = "";
	$self->{"age"} = 0;
	return $self;
}
sub set_name
{
	my $self    = shift;
	my $value   = shift;
	$self->{"name"} = $value;
}

sub get_name
{
	my $self = shift;
	return $self->{"name"};
}


sub newClassObj2
{
	my $class   = shift;
	my $self    = {@_ };
	bless       $self;
	return      $self;
}


package main;
# ---   no we are back package 'main'


#
#   --- use new1()  :explicit methods
#
$worker = P_BaseClass->newClassObj();      # constructor ist 'package->new()'
$worker->set_name("Fred Flintstone");
print "Worker is named '" . $worker->get_name() . "' \n";


#
#   --- use new2()  :no methods
#
$worker = P_BaseClass->newClassObj2(
        "name1" => "Peter Meier",
        "id"    => 1234,
        "age"   => 40
);
print "Worker has age '" . $worker->{age} . "' \n";



#  package main;
# ---   no we are back package 'main'


# ============================================================================
# 2) Sub-Klassen
# ============================================================================
&dbg_TRACE("2) SubKlassen",__FILE__,__LINE__);
package P_SubClass;

package main;
&dbg_TRACE($PGMNAME,__FILE__,__LINE__);
exit($iEc);

__END__