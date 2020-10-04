defmodule HEBGenerationTest do
  use ExUnit.Case, async: true

  test "HEB graph is generated for the `module_a_calls_b` project" do
    # given
    project = "module_a_calls_b"

    # when
    output = svg_generated(project)

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_b_and_b_calls_a` project" do
    # given
    project = "module_a_calls_b_and_b_calls_a"

    # when
    output = svg_generated(project)

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       1 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       1 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path><path style="mix-blend-mode: multiply;" d="M-377,6.925377649178281e-14L-314.1666666666667,5.828859521391721e-14C-251.33333333333334,4.7323413936051595e-14,-125.66666666666667,2.5393051380320365e-14,0,1.0003323271035294e-14C125.66666666666667,-5.386404838249776e-15,251.33333333333334,-1.4235498501088692e-14,314.1666666666667,-1.8660045332508148e-14L377,-2.3084592163927607e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_b` and `module_c_calls_b` projects" do
    # given
    projects = ["module_a_calls_b", "module_c_calls_b"]

    # when
    output = svg_generated(projects)

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-30.000000000000007) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       0 outgoing
                       2 incoming</title></text></g><g transform="rotate(210.00000000000006) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">C<title>C
                       1 outgoing
                       0 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L276.1574590709453,-154.72708333333335C225.82334091515725,-120.9541666666667,125.15510460358111,-53.40833333333334,70.73984173245891,40.84166666666666C16.32457886133669,135.09166666666667,8.162289430668368,256.04583333333335,4.081144715334208,316.5229166666667L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M-326.49157722673334,-188.50000000000003L-276.1574590709453,-154.72708333333335C-225.82334091515722,-120.9541666666667,-125.15510460358111,-53.40833333333334,-70.73984173245888,40.84166666666666C-16.32457886133665,135.09166666666667,-8.1622894306683,256.04583333333335,-4.081144715334127,316.5229166666667L4.7770319507798133e-14,377"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_matches_on_a_struct_from_b_and_c` project" do
    # given
    project = "module_a_matches_on_a_struct_from_b_and_c"

    # when
    output = svg_generated(project)

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-30.000000000000007) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       2 outgoing
                       0 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(210.00000000000006) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">C<title>C
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L276.1574590709453,-154.72708333333335C225.82334091515725,-120.9541666666667,125.15510460358111,-53.40833333333334,70.73984173245891,40.84166666666666C16.32457886133669,135.09166666666667,8.162289430668368,256.04583333333335,4.081144715334208,316.5229166666667L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L272.07631435561115,-161.79583333333335C217.6610514844889,-135.0916666666667,108.83052574224445,-81.68333333333335,0,-81.68333333333335C-108.83052574224445,-81.68333333333335,-217.6610514844889,-135.0916666666667,-272.07631435561115,-161.79583333333335L-326.49157722673334,-188.50000000000003"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_dep_without_any_deps` project with " <>
         "max deps depth 1" do
    # given
    project = "module_a_calls_dep_without_any_deps"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "1"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Maybe<title>FE.Maybe
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_dep_without_any_deps` project with " <>
         "max deps depth 2" do
    # given
    project = "module_a_calls_dep_without_any_deps"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "2"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-54) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(18) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">Maybe<title>FE.Maybe
                       3 outgoing
                       3 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Error<title>FE.Maybe.Error
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(162) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Result<title>FE.Result
                       2 outgoing
                       2 incoming</title></text></g><g transform="rotate(234) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Review<title>FE.Review
                       2 outgoing
                       2 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M221.59504011426236,-304.9994068793552L191.91432526302114,-256.5224223994627C162.23361041177995,-208.04543791957016,102.87218070929755,-111.09146895978508,125.69772513079931,-40.841666666666676C148.52326955230106,29.408135626451713,253.53578809778696,72.95377125290342,306.04204737052993,94.72658906612929L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L303.27210936910166,103.25158165212122C247.99591209493042,90.0037564248873,137.44351754658794,63.50810597041948,77.68546643937582,106.92487149052697C17.927415332163665,150.34163701063443,8.963707666081858,263.6708185053172,4.481853833040952,320.3354092526586L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L298.7902555360608,99.99532423811316C239.0322044288486,83.49124159687119,119.5161022144243,50.48307631438723,0,50.483076314387255C-119.5161022144243,50.48307631438727,-239.0322044288486,83.49124159687125,-298.7902555360608,99.99532423811324L-358.5483066432729,116.49940687935523"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L300.5021713676734,94.72658906612928C242.45603609207387,72.95377125290344,126.36376554087481,29.408135626451713,29.673207747952265,-40.841666666666676C-67.01735004497029,-111.09146895978506,-144.30619507961637,-208.04543791957016,-182.9506175969394,-256.52242239946264L-221.59504011426245,-304.9994068793552"></path><path style="mix-blend-mode: multiply;" d="M-358.5483066432729,116.49940687935523L-298.7902555360608,99.99532423811324C-239.0322044288486,83.49124159687125,-119.5161022144243,50.48307631438727,0,50.483076314387255C119.5161022144243,50.48307631438723,239.0322044288486,83.49124159687119,298.7902555360608,99.99532423811316L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M-358.5483066432729,116.49940687935523L-306.04204737052993,94.72658906612935C-253.535788097787,72.9537712529035,-148.52326955230106,29.40813562645175,-125.69772513079931,-40.84166666666666C-102.87218070929758,-111.09146895978506,-162.23361041178,-208.04543791957016,-191.9143252630212,-256.52242239946264L-221.59504011426242,-304.9994068793552"></path><path style="mix-blend-mode: multiply;" d="M-221.59504011426242,-304.9994068793552L-182.9506175969394,-256.5224223994627C-144.30619507961634,-208.04543791957016,-67.01735004497029,-111.09146895978506,29.673207747952272,-40.841666666666676C126.36376554087481,29.408135626451713,242.45603609207387,72.95377125290344,300.5021713676734,94.72658906612929L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M-221.59504011426242,-304.9994068793552L-191.9143252630212,-256.5224223994627C-162.23361041178,-208.04543791957016,-102.87218070929758,-111.09146895978506,-125.69772513079933,-40.841666666666654C-148.52326955230106,29.40813562645175,-253.535788097787,72.9537712529035,-306.04204737052993,94.72658906612936L-358.5483066432729,116.49940687935523"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `modules_a_and_b_call_dep_in_an_umbrella` project with " <>
         "max deps depth 0" do
    # given
    project = "modules_a_and_b_call_dep_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "0"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `modules_a_and_b_call_dep_in_an_umbrella` project with " <>
         "max deps depth 1" do
    # given
    project = "modules_a_and_b_call_dep_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "1"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-30.000000000000007) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       2 outgoing
                       0 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       1 outgoing
                       1 incoming</title></text></g><g transform="rotate(210.00000000000006) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Maybe<title>FE.Maybe
                       0 outgoing
                       2 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L276.1574590709453,-154.72708333333335C225.82334091515725,-120.9541666666667,125.15510460358111,-53.40833333333334,70.73984173245891,40.84166666666666C16.32457886133669,135.09166666666667,8.162289430668368,256.04583333333335,4.081144715334208,316.5229166666667L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L272.07631435561115,-161.79583333333335C217.6610514844889,-135.0916666666667,108.83052574224445,-81.68333333333335,0,-81.68333333333335C-108.83052574224445,-81.68333333333335,-217.6610514844889,-135.0916666666667,-272.07631435561115,-161.79583333333335L-326.49157722673334,-188.50000000000003"></path><path style="mix-blend-mode: multiply;" d="M4.6169184327855214e-14,377L-4.081144715334128,316.5229166666667C-8.162289430668302,256.04583333333335,-16.32457886133665,135.09166666666667,-70.73984173245888,40.84166666666666C-125.15510460358111,-53.40833333333334,-225.82334091515722,-120.9541666666667,-276.1574590709453,-154.72708333333335L-326.49157722673334,-188.50000000000003"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `modules_a_and_b_call_dep_in_an_umbrella` project with " <>
         "max deps depth 2" do
    # given
    project = "modules_a_and_b_call_dep_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "2"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-60) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       2 outgoing
                       0 incoming</title></text></g><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">B<title>B
                       1 outgoing
                       1 incoming</title></text></g><g transform="rotate(60.00000000000003) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">Maybe<title>FE.Maybe
                       3 outgoing
                       4 incoming</title></text></g><g transform="rotate(120) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Error<title>FE.Maybe.Error
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Result<title>FE.Result
                       2 outgoing
                       2 incoming</title></text></g><g transform="rotate(239.99999999999994) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Review<title>FE.Review
                       2 outgoing
                       2 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M188.49999999999997,-326.4915772267334L164.1520833333333,-276.1574590709453C139.80416666666665,-225.82334091515727,91.10833333333333,-125.15510460358114,122.52499999999999,-70.73984173245891C153.9416666666667,-16.32457886133668,265.47083333333336,-8.16228943066835,321.23541666666665,-4.081144715334185L377,-1.9621903339338465e-14"></path><path style="mix-blend-mode: multiply;" d="M188.49999999999997,-326.4915772267334L161.79583333333332,-272.07631435561115C135.09166666666664,-217.66105148448892,81.68333333333332,-108.83052574224446,81.68333333333332,0C81.68333333333332,108.83052574224446,135.09166666666664,217.66105148448892,161.79583333333332,272.07631435561115L188.49999999999997,326.4915772267334"></path><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L321.23541666666665,4.0811447153341485C265.47083333333336,8.162289430668318,153.9416666666667,16.32457886133666,122.52500000000002,70.7398417324589C91.10833333333333,125.15510460358114,139.80416666666665,225.82334091515727,164.1520833333333,276.1574590709453L188.49999999999997,326.4915772267334"></path><path style="mix-blend-mode: multiply;" d="M188.49999999999997,326.4915772267334L157.08333333333331,280.2386037862795C125.66666666666664,233.9856303458256,62.83333333333332,141.47968346491783,-1.4210854715202004e-14,141.4796834649178C-62.83333333333334,141.4796834649178,-125.66666666666669,233.98563034582557,-157.08333333333334,280.2386037862795L-188.50000000000003,326.49157722673334"></path><path style="mix-blend-mode: multiply;" d="M188.49999999999997,326.4915772267334L154.7270833333333,276.1574590709453C120.95416666666665,225.82334091515727,53.408333333333324,125.15510460358114,-40.841666666666676,70.73984173245891C-135.09166666666667,16.324578861336697,-256.04583333333335,8.162289430668382,-316.5229166666667,4.081144715334225L-377,6.739222284713659e-14"></path><path style="mix-blend-mode: multiply;" d="M188.49999999999997,326.4915772267334L157.08333333333331,272.07631435561115C125.66666666666664,217.66105148448892,62.833333333333314,108.83052574224446,-4.263256414560601e-14,2.842170943040401e-14C-62.8333333333334,-108.83052574224443,-125.66666666666679,-217.66105148448887,-157.08333333333348,-272.07631435561103L-188.50000000000017,-326.4915772267333"></path><path style="mix-blend-mode: multiply;" d="M-377,6.925377649178281e-14L-316.5229166666667,4.081144715334227C-256.04583333333335,8.162289430668384,-135.09166666666667,16.3245788613367,-40.841666666666676,70.73984173245891C53.408333333333324,125.15510460358114,120.95416666666665,225.82334091515727,154.7270833333333,276.1574590709453L188.49999999999997,326.4915772267334"></path><path style="mix-blend-mode: multiply;" d="M-377,6.925377649178281e-14L-321.23541666666665,-4.0811447153341085C-265.47083333333336,-8.162289430668286,-153.9416666666667,-16.32457886133664,-122.52500000000005,-70.73984173245886C-91.1083333333334,-125.1551046035811,-139.8041666666668,-225.82334091515716,-164.15208333333348,-276.1574590709452L-188.50000000000017,-326.4915772267333"></path><path style="mix-blend-mode: multiply;" d="M-188.50000000000017,-326.4915772267333L-157.08333333333348,-272.07631435561103C-125.66666666666679,-217.66105148448887,-62.8333333333334,-108.83052574224443,-4.263256414560601e-14,2.842170943040401e-14C62.833333333333314,108.83052574224446,125.66666666666664,217.66105148448892,157.08333333333331,272.07631435561115L188.49999999999997,326.4915772267334"></path><path style="mix-blend-mode: multiply;" d="M-188.50000000000017,-326.4915772267333L-164.15208333333348,-276.1574590709452C-139.8041666666668,-225.82334091515716,-91.1083333333334,-125.1551046035811,-122.52500000000005,-70.73984173245887C-153.9416666666667,-16.324578861336644,-265.47083333333336,-8.162289430668286,-321.23541666666665,-4.081144715334109L-377,6.739222284713659e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_enum` project with " <>
         "builtin modules included" do
    # given
    project = "module_a_calls_enum"

    # when
    output = svg_generated(project, %{"BUILTIN" => "true"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Enum<title>Enum
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_enum` project without " <>
         "builtin modules and no deps" do
    # given
    project = "modules_a_and_b_call_dep_and_builtin_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "0"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(0) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       1 outgoing
                       0 incoming</title></text></g><g transform="rotate(180) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M377,-2.3084592163927607e-14L314.1666666666667,-1.866004533250815e-14C251.33333333333334,-1.4235498501088692e-14,125.66666666666667,-5.386404838249774e-15,0,1.0003323271035294e-14C-125.66666666666667,2.5393051380320365e-14,-251.33333333333334,4.7323413936051595e-14,-314.1666666666667,5.828859521391721e-14L-377,6.925377649178281e-14"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_enum` project with " <>
         "builtin modules and no deps" do
    # given
    project = "modules_a_and_b_call_dep_and_builtin_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "0", "BUILTIN" => "true"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-45) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       2 outgoing
                       0 incoming</title></text></g><g transform="rotate(45) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">B<title>B
                       1 outgoing
                       1 incoming</title></text></g><g transform="rotate(135) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Enum<title>Enum
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(225) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">List<title>List
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M266.5792565073284,-266.5792565073284L228.8138618354569,-222.14938042277367C191.04846716358534,-177.71950433821894,115.51767781984232,-88.85975216910947,115.51767781984232,0C115.51767781984232,88.85975216910947,191.04846716358534,177.71950433821894,228.8138618354569,222.14938042277367L266.5792565073284,266.5792565073284"></path><path style="mix-blend-mode: multiply;" d="M266.5792565073284,-266.5792565073284L222.14938042277367,-228.8138618354569C177.71950433821894,-191.04846716358534,88.85975216910947,-115.51767781984232,-9.473903143468002e-15,-115.51767781984229C-88.85975216910948,-115.51767781984229,-177.71950433821897,-191.04846716358531,-222.1493804227737,-228.81386183545683L-266.57925650732847,-266.57925650732835"></path><path style="mix-blend-mode: multiply;" d="M266.5792565073284,266.5792565073284L222.14938042277367,228.8138618354569C177.71950433821894,191.04846716358534,88.85975216910947,115.51767781984232,0,115.51767781984233C-88.85975216910947,115.51767781984233,-177.71950433821894,191.0484671635854,-222.14938042277367,228.81386183545692L-266.5792565073284,266.57925650732847"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_enum` project without " <>
         "builtin modules and with one level of deps" do
    # given
    project = "modules_a_and_b_call_dep_and_builtin_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "1"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-30.000000000000007) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       2 outgoing
                       0 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">B<title>B
                       1 outgoing
                       1 incoming</title></text></g><g transform="rotate(210.00000000000006) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Maybe<title>FE.Maybe
                       0 outgoing
                       2 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L276.1574590709453,-154.72708333333335C225.82334091515725,-120.9541666666667,125.15510460358111,-53.40833333333334,70.73984173245891,40.84166666666666C16.32457886133669,135.09166666666667,8.162289430668368,256.04583333333335,4.081144715334208,316.5229166666667L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M326.49157722673334,-188.50000000000003L272.07631435561115,-161.79583333333335C217.6610514844889,-135.0916666666667,108.83052574224445,-81.68333333333335,0,-81.68333333333335C-108.83052574224445,-81.68333333333335,-217.6610514844889,-135.0916666666667,-272.07631435561115,-161.79583333333335L-326.49157722673334,-188.50000000000003"></path><path style="mix-blend-mode: multiply;" d="M4.6169184327855214e-14,377L-4.081144715334128,316.5229166666667C-8.162289430668302,256.04583333333335,-16.32457886133665,135.09166666666667,-70.73984173245888,40.84166666666666C-125.15510460358111,-53.40833333333334,-225.82334091515722,-120.9541666666667,-276.1574590709453,-154.72708333333335L-326.49157722673334,-188.50000000000003"></path></g></svg>
           """
  end

  test "HEB graph is generated for the `module_a_calls_enum` project with " <>
         "builtin modules and with one level of deps" do
    # given
    project = "modules_a_and_b_call_dep_and_builtin_in_an_umbrella"

    # when
    output = svg_generated(project, %{"MAX_DEPS_DEPTH" => "1", "BUILTIN" => "true"})

    # then
    assert output == """
           <svg viewBox="-477,-477,954,954" xmlns="http://www.w3.org/2000/svg"><g font-family="sans-serif" font-size="10"><g transform="rotate(-64.28571428571428) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">A<title>A
                       3 outgoing
                       0 incoming</title></text></g><g transform="rotate(-12.857142857142847) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">B<title>B
                       2 outgoing
                       1 incoming</title></text></g><g transform="rotate(38.571428571428555) translate(377,0)"><text dy="0.31em" x="6" text-anchor="start">Enum<title>Enum
                       0 outgoing
                       2 incoming</title></text></g><g transform="rotate(90) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">EmptyError<title>Enum.EmptyError
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(141.42857142857142) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">Maybe<title>FE.Maybe
                       3 outgoing
                       2 incoming</title></text></g><g transform="rotate(192.85714285714283) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">List<title>List
                       0 outgoing
                       1 incoming</title></text></g><g transform="rotate(244.28571428571428) translate(377,0)"><text dy="0.31em" x="-6" text-anchor="end" transform="rotate(180)">erlang<title>erlang
                       0 outgoing
                       1 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M163.57416964731942,-339.665263199212L142.95083294618118,-288.3488316906026C122.32749624504295,-237.03240018199324,81.0808228427665,-134.39953716477447,115.07643171697117,-91.77039198182756C149.07204059117586,-49.14124679888065,258.3099317418617,-66.5158194502056,312.9288773172046,-75.20310577586808L367.5478228925475,-83.89039210153055"></path><path style="mix-blend-mode: multiply;" d="M163.57416964731942,-339.665263199212L134.67210429889374,-284.36200609807423C105.77003895046808,-229.0587489969364,47.96590825361675,-118.4522347946608,-28.42153150267768,-22.665415044668368C-104.80897125897211,73.12140470532407,-199.77972007470964,154.08853000303336,-247.2650944825784,194.57209265188797L-294.75046889044717,235.05565530074261"></path><path style="mix-blend-mode: multiply;" d="M163.57416964731942,-339.665263199212L133.7621373738675,-288.3488316906026C103.95010510041557,-237.03240018199324,44.32604055351174,-134.39953716477447,-44.19429153646609,-91.77039198182753C-132.7146236264439,-49.141246798880616,-250.13122325949573,-66.51581945020554,-308.8395230760216,-75.203105775868L-367.5478228925475,-83.89039210153047"></path><path style="mix-blend-mode: multiply;" d="M367.5478228925475,-83.89039210153055L314.5685810577437,-68.01909429461864C261.5893392229399,-52.147796487706735,155.63085555333225,-20.40520087388292,143.49796321964888,32.75247369316259C131.3650708859655,85.91014826020812,213.0577698882064,160.48290178047532,253.90411938932684,197.76927854060895L294.7504688904473,235.05565530074253"></path><path style="mix-blend-mode: multiply;" d="M367.5478228925475,-83.89039210153055L307.1998193354826,-68.01909429461864C246.85181577841752,-52.14779648770673,126.15580866428752,-20.405200873882915,15.772760033788407,32.752473693162614C-94.6102885967107,85.91014826020815,-194.68037874357893,160.48290178047537,-244.71542381701303,197.769278540609L-294.75046889044717,235.05565530074261"></path><path style="mix-blend-mode: multiply;" d="M-294.75046889044717,235.05565530074261L-245.6253907420393,201.75610413313743C-196.50031259363143,168.4565529655322,-98.25015629681572,101.8574506303218,2.842170943040401e-14,101.8574506303218C98.25015629681576,101.85745063032176,196.50031259363152,168.45655296553215,245.6253907420394,201.75610413313734L294.7504688904473,235.05565530074253"></path><path style="mix-blend-mode: multiply;" d="M-294.75046889044717,235.05565530074261L-249.30977160316988,203.53040844187817C-203.86907431589262,172.00516158301366,-112.98767974133807,108.95466786528466,-63.86260159293021,132.61205864849424C-14.73752344452234,156.2694494317038,-7.368761722261147,266.6347247158519,-3.6843808611305495,321.81736235792596L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M-294.75046889044717,235.05565530074261L-251.35444872376138,194.57209265188797C-207.95842855707562,154.08853000303336,-121.16638822370406,73.12140470532407,-99.30367168318277,-22.665415044668354C-77.44095514266151,-118.45223479466078,-120.5075623949905,-229.05874899693637,-142.040866021155,-284.3620060980742L-163.5741696473195,-339.66526319921195"></path></g></svg>
           """
  end

  defp svg_generated(projects, options \\ %{})

  defp svg_generated(projects, options) when is_list(projects) do
    project_dirs = Enum.map(projects, &project_dir/1)

    {output, 0} =
      System.cmd(
        "bash",
        ["./priv/generate.sh" | project_dirs],
        env: options
      )

    output
  end

  defp svg_generated(project, options), do: svg_generated([project], options)

  defp project_dir(project_name) do
    Path.join([File.cwd!(), "test", "test_projects", project_name])
  end
end
