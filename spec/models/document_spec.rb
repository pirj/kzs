require 'spec_helper'

describe Organization do

  it { should belong_to(:organization) }
  it { should belong_to(:approver) }
  it { should belong_to(:executor) }

end