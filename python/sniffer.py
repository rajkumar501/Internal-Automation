#!/usr/bin/env python3
import argparse
from collections import defaultdict
from scapy.all import sniff, DNSQR, IP, get_if_list
import psutil
import sys

def list_all_ifaces():
    print("\n📋  pcap interfaces:")
    pcap_ifaces = get_if_list()
    for i, name in enumerate(pcap_ifaces):
        print(f"  [{i}] {name}")
    if not pcap_ifaces:
        print("    (none!)")

    print("\n📋  OS network interfaces:")
    for i, name in enumerate(psutil.net_if_addrs().keys()):
        print(f"  (os){i} {name}")
    print()
    return pcap_ifaces

def handle_packet(pkt):
    if pkt.haslayer(DNSQR) and IP in pkt:
        src = pkt[IP].src
        dom = pkt[DNSQR].qname.decode(errors='ignore').rstrip('.')
        COUNTS[src][dom] += 1

def print_summary(top_n):
    print("\n=== DNS Lookup Summary ===")
    for ip, domains in COUNTS.items():
        print(f"\nDevice: {ip}")
        for dom, cnt in sorted(domains.items(), key=lambda x: x[1], reverse=True)[:top_n]:
            print(f"  {dom:<40}  {cnt:>5}")
    print("\nDone.\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i","--iface", help="pcap iface (as shown above)")
    parser.add_argument("-t","--top", type=int, default=10, help="top N domains")
    parser.add_argument("-d","--duration", type=int, default=0, help="auto‐stop secs")
    args = parser.parse_args()

    all_ifaces = list_all_ifaces()
    if args.iface:
        iface = args.iface
    else:
        choice = input("Enter pcap interface index (or Enter for default): ").strip()
        if choice == "":
            iface = None
        else:
            try:
                idx = int(choice)
                iface = all_ifaces[idx]
            except:
                print("Invalid choice, exiting."); sys.exit(1)

    print(f"\nSniffing on: {iface or 'default interface'}")
    COUNTS = defaultdict(lambda: defaultdict(int))
    sniff_args = dict(filter="udp port 53", prn=handle_packet, store=False)
    if iface:
        sniff_args["iface"] = iface
    if args.duration>0:
        sniff_args["timeout"] = args.duration

    try:
        sniff(**sniff_args)
    except PermissionError:
        print("❌ Permission denied: run as Administrator with Npcap installed.")
        sys.exit(1)

    print_summary(args.top)
