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
    output = svg_generated(project, ["--max-deps-depth=1"])

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
    output = svg_generated(project, ["--max-deps-depth=2"])

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
                2 incoming</title></text></g></g><g stroke="#ccc" fill="none"><path style="mix-blend-mode: multiply;" d="M221.59504011426236,-304.9994068793552L191.91432526302114,-256.5224223994627C162.23361041177995,-208.04543791957016,102.87218070929755,-111.09146895978508,125.69772513079931,-40.841666666666676C148.52326955230106,29.408135626451713,253.53578809778696,72.95377125290342,306.04204737052993,94.72658906612929L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L298.7902555360608,99.99532423811316C239.0322044288486,83.49124159687119,119.5161022144243,50.48307631438723,0,50.483076314387255C-119.5161022144243,50.48307631438727,-239.0322044288486,83.49124159687125,-298.7902555360608,99.99532423811324L-358.5483066432729,116.49940687935523"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L300.5021713676734,94.72658906612928C242.45603609207387,72.95377125290344,126.36376554087481,29.408135626451713,29.673207747952265,-40.841666666666676C-67.01735004497029,-111.09146895978506,-144.30619507961637,-208.04543791957016,-182.9506175969394,-256.52242239946264L-221.59504011426245,-304.9994068793552"></path><path style="mix-blend-mode: multiply;" d="M358.5483066432729,116.49940687935515L303.27210936910166,103.25158165212122C247.99591209493042,90.0037564248873,137.44351754658794,63.50810597041948,77.68546643937582,106.92487149052697C17.927415332163665,150.34163701063443,8.963707666081858,263.6708185053172,4.481853833040952,320.3354092526586L4.7770319507798133e-14,377"></path><path style="mix-blend-mode: multiply;" d="M-358.5483066432729,116.49940687935523L-298.7902555360608,99.99532423811324C-239.0322044288486,83.49124159687125,-119.5161022144243,50.48307631438727,0,50.483076314387255C119.5161022144243,50.48307631438723,239.0322044288486,83.49124159687119,298.7902555360608,99.99532423811316L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M-358.5483066432729,116.49940687935523L-306.04204737052993,94.72658906612935C-253.535788097787,72.9537712529035,-148.52326955230106,29.40813562645175,-125.69772513079931,-40.84166666666666C-102.87218070929758,-111.09146895978506,-162.23361041178,-208.04543791957016,-191.9143252630212,-256.52242239946264L-221.59504011426242,-304.9994068793552"></path><path style="mix-blend-mode: multiply;" d="M-221.59504011426242,-304.9994068793552L-182.9506175969394,-256.5224223994627C-144.30619507961634,-208.04543791957016,-67.01735004497029,-111.09146895978506,29.673207747952272,-40.841666666666676C126.36376554087481,29.408135626451713,242.45603609207387,72.95377125290344,300.5021713676734,94.72658906612929L358.5483066432729,116.49940687935515"></path><path style="mix-blend-mode: multiply;" d="M-221.59504011426242,-304.9994068793552L-191.9143252630212,-256.5224223994627C-162.23361041178,-208.04543791957016,-102.87218070929758,-111.09146895978506,-125.69772513079933,-40.841666666666654C-148.52326955230106,29.40813562645175,-253.535788097787,72.9537712529035,-306.04204737052993,94.72658906612936L-358.5483066432729,116.49940687935523"></path></g></svg>
    """
  end

  defp svg_generated(projects, options \\ [])
  defp svg_generated(projects, options) when is_list(projects) do
    project_dirs = Enum.map(projects, &project_dir/1)
    {output, 0} = System.cmd("bash", ["./priv/generate.sh" | options ++ project_dirs])
    output
  end
  defp svg_generated(project, options), do: svg_generated([project], options)

  defp project_dir(project_name) do
    Path.join([File.cwd!(), "test", "test_projects", project_name])
  end
end
