#!/usr/bin/env python

with open("HTseq_out.txt", "r") as sl:
    with open("SRR25630310_strnd","w") as fwd_310:
        with open("SRR25630391_strnd","w") as fwd_391:
            with open("SRR25630310_rvs_strnd","w") as rvs_310:
                with open("SRR25630391_rvs_strnd","w") as rvs_391:
                    file_cnt = 0
                    for line in sl:
                        if "-gene-" in line or line.startswith("__"):
                            if file_cnt == 0:
                                fwd_310.write(f"{line}")
                            elif file_cnt == 1:
                                fwd_391.write(f"{line}")
                            elif file_cnt == 2:
                                rvs_310.write(f"{line}")
                            elif file_cnt == 3:
                                rvs_391.write(f"{line}")
                            if "alignment_not_unique" in line:
                                file_cnt += 1
                        else:
                            continue


